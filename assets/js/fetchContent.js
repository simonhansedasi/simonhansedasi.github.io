document.addEventListener('DOMContentLoaded', function() {
  async function fetchContent() {
    try {
      const response = await fetch('/assets/art.json');
      if (!response.ok) throw new Error('Failed to fetch data');
      const data = await response.json();

      const haikus = data.haikus;
      const images = data.images;

      if (!Array.isArray(haikus) || !Array.isArray(images)) {
        throw new Error('Data is not in the expected format');
      }

      // Find today's haiku from 2022 (try 2022 first, fall back to 2023)
      const today = new Date();
      const month = String(today.getMonth() + 1).padStart(2, '0');
      const day   = String(today.getDate()).padStart(2, '0');

      const date2022 = `2022/${month}/${day}`;
      const date2023 = `2023/${month}/${day}`;

      const haiku = haikus.find(h => h.date === date2022)
                 || haikus.find(h => h.date === date2023)
                 || haikus[0];

      const formattedContent = haiku.content.replace(/\n/g, '<br>');

      document.getElementById('haiku-container').innerHTML = `
        <p><em>${haiku.date}</em></p>
        <p>${formattedContent}</p>
      `;

      // Random image
      const randomImage = images[Math.floor(Math.random() * images.length)];
      document.getElementById('image-container').innerHTML =
        `<img src="${randomImage}" alt="Math art">`;

    } catch (error) {
      console.error('Error fetching content:', error);
      document.getElementById('haiku-container').innerHTML = '<p>Sorry, there was an error fetching the haiku.</p>';
      document.getElementById('image-container').innerHTML = '<p>Sorry, there was an error fetching the image.</p>';
    }
  }

  fetchContent();
});
