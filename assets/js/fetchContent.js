document.addEventListener('DOMContentLoaded', function() {
  async function fetchRandomContent() {
    try {
      console.log('Starting fetch for JSON data');

      // Fetch data from the JSON file
      const response = await fetch('/assets/art.json');
      if (!response.ok) throw new Error('Failed to fetch data');

      const data = await response.json();
      console.log('Fetched data:', data);

      // Extract haikus and images
      const haikus = data.haikus;
      const images = data.images;
      console.log('Extracted haikus:', haikus);
      console.log('Extracted images:', images);

      if (!Array.isArray(haikus) || !Array.isArray(images)) {
        throw new Error('Data is not in the expected format');
      }

      // Select random haiku and image
      const randomHaiku = haikus[Math.floor(Math.random() * haikus.length)];
      const randomImage = images[Math.floor(Math.random() * images.length)];

      console.log('Selected haiku:', randomHaiku);
      console.log('Selected image:', randomImage);

      // Convert newlines to <br> tags
      const formattedContent = randomHaiku.content.replace(/\n/g, '<br>');

      // Update HTML with the fetched data
      document.getElementById('haiku-container').innerHTML = `
        <p><strong>Date:</strong> ${randomHaiku.date}</p>
        <p><strong>Number:</strong> ${randomHaiku.number}</p>
        <p>${formattedContent}</p>
      `;
      document.getElementById('image-container').innerHTML = `<img src="${randomImage}" alt="Random Art Image">`;

    } catch (error) {
      console.error('Error fetching content:', error);
      document.getElementById('haiku-container').innerHTML = '<p>Sorry, there was an error fetching the haiku.</p>';
      document.getElementById('image-container').innerHTML = '<p>Sorry, there was an error fetching the image.</p>';
    }
  }

  fetchRandomContent();
});
