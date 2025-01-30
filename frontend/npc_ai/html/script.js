window.addEventListener('message', function(event) {
    if (event.data.action === 'playVoice') {
        let audioUrl = event.data.url;
        let audioElement = document.getElementById('npc-voice');
        
        // Set the audio source to the provided URL and play it
        audioElement.src = audioUrl;
        audioElement.style.display = 'block';  // Show the audio player (optional)
        
        // Automatically play the audio
        audioElement.play().catch(err => {
            console.error('Error playing voice audio:', err);
        });
        
        // Hide the audio player once playback is finished
        audioElement.onended = function() {
            audioElement.style.display = 'none';
        };
    }
});
