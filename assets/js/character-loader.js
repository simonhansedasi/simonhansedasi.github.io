async function loadCharacter() {
    document.getElementById("character-container").innerHTML = "Generating character...";

    const statOrder = ['STR', 'DEX', 'CON', 'INT', 'WIS', 'CHA'];

    async function fetchWithTimeout(resource, options = {}) {
        const { timeout = 10000 } = options;
        const controller = new AbortController();
        const id = setTimeout(() => controller.abort(), timeout);
        try {
            const response = await fetch(resource, {
                ...options,
                signal: controller.signal
            });
            clearTimeout(id);
            if (!response.ok) throw new Error(`Request failed with status ${response.status}`);
            return await response.json();
        } catch (error) {
            clearTimeout(id);
            throw error;
        }
    }

    try {
        console.log("Starting character generation fetch...");
        const characterData = await fetchWithTimeout("https://char-gen.onrender.com/generate_character", {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            timeout: 10000
        });

        console.log("Full character data response:", characterData);
        if (!characterData.stats) throw new Error("Character stats not found.");

        const orderedStats = statOrder.reduce((acc, stat, index) => {
            if (characterData.stats && characterData.stats[index] !== undefined) {
                acc[stat] = characterData.stats[index];
            }
            return acc;
        }, {});

        document.getElementById("character-container").innerHTML = `
            <h2>${characterData.species} ${characterData.class}</h2>
            <h3>Stats:</h3> [${Object.entries(orderedStats).map(([key, value]) => `${key}: ${value}`).join(', ')}]
            <p><strong>Background:</strong> ${characterData.background}</p>
            <p><strong>Character Backstory:</strong></p>
            <div id="backstory-container">Loading...</div>
        `;

        console.log("Starting background generation fetch...");
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
            timeout: 10000
        });

        document.querySelector('#backstory-container').innerHTML = backgroundData.character_background;

    } catch (error) {
        console.error("Error loading character:", error.message || error);
        doc

