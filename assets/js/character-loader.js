async function loadCharacter() {
    document.getElementById("character-container").innerHTML = "Generating character...";

    // Define the desired order for stats
    const statOrder = ['STR', 'DEX', 'CON', 'INT', 'WIS', 'CHA'];

    // Custom function to handle fetch with a timeout
    async function fetchWithTimeout(resource, options = {}) {
        const { timeout = 10000 } = options; // Set a 10-second timeout by default
        const controller = new AbortController();
        const id = setTimeout(() => controller.abort(), timeout);

        try {
            const response = await fetch(resource, {
                ...options,
                signal: controller.signal
            });
            clearTimeout(id);

            // Check if the response status is okay (200-299)
            if (!response.ok) {
                throw new Error(`Request failed with status ${response.status}`);
            }

            return await response.json();
        } catch (error) {
            clearTimeout(id);
            throw error;
        }
    }

    try {
        console.log("Window loaded. Starting character load process...");

        // Log fetch start time for character data
        const characterFetchStart = performance.now();
        console.log('Starting fetch for character data at:', new Date().toISOString());

        // First fetch: main character data without background
        const characterData = await fetchWithTimeout("https://char-gen.onrender.com/generate_character", {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            timeout: 20000 // Set a timeout of 10 seconds for this request
        });

        // Log fetch end time for character data
        const characterFetchEnd = performance.now();
        console.log('Character data fetch completed at:', new Date().toISOString());
        console.log('Character data fetch took:', (characterFetchEnd - characterFetchStart) / 1000, 'seconds');

        // Debugging: Log the full character data to inspect
        console.log("Full character data response:", characterData);

        // Check if stats are available
        if (!characterData.stats) {
            console.error("Stats are missing in the character data");
            document.getElementById("character-container").innerText = "Error: Character stats not found.";
            return;
        }

        // Reorder stats based on statOrder array
        const orderedStats = statOrder.reduce((acc, stat, index) => {
            if (characterData.stats && characterData.stats[index] !== undefined) {
                acc[stat] = characterData.stats[index];
            }
            return acc;
        }, {});

        // Check if orderedStats is not empty before rendering
        if (Object.keys(orderedStats).length === 0) {
            console.error("Ordered stats are empty");
            document.getElementById("character-container").innerText = "Error: No stats found.";
            return;
        }

        // Display character info
        document.getElementById("character-container").innerHTML = `
            <h2>${characterData.alignment} ${characterData.species} ${characterData.class}</h2>
            <h3>Stats:</h3> [${Object.entries(orderedStats).map(([key, value]) => `${key}: ${value}`).join(', ')}]
            <p><strong>Background:</strong> ${characterData.background}</p>
            <p><strong>Character Backstory:</strong></p>
            <div id="backstory-container">Loading...</div> <!-- Add loading message for backstory -->
        `;

        console.log("Starting background generation fetch...");

        // Log fetch start time for background data
        const backgroundFetchStart = performance.now();
        console.log('Starting fetch for background data at:', new Date().toISOString());

        // Second fetch: background data
        const backgroundData = await fetchWithTimeout("https://char-gen.onrender.com/generate_background", {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                'species': characterData.species,
                'class': characterData.class,
                'stats': characterData.stats,
                'dead_farmers': characterData.dead_farmers,
                'background': characterData.background
            }),
            timeout: 20000 // Set a timeout of 10 seconds for this request
        });

        // Log fetch end time for background data
        const backgroundFetchEnd = performance.now();
        console.log('Background data fetch completed at:', new Date().toISOString());
        console.log('Background data fetch took:', (backgroundFetchEnd - backgroundFetchStart) / 1000, 'seconds');

        // Update backstory once it's fetched
        document.querySelector('#backstory-container').innerHTML = backgroundData.character_background;

    } catch (error) {
        console.error("Error loading character:", error.message || error);
        document.getElementById("character-container").innerText = "Error loading character data.";
    }
}

// Add delay on window load in case the backend takes time to initialize
window.onload = () => setTimeout(loadCharacter, 3000); // 3-second delay for testing
