# video2image
FFMPEG bash script to extract image sequence by user defined interval

<pre>
1. Takes a video path and an interval in seconds as input
2. Calculates the total duration of the video using ffprobe
3. Output directory named after the video file (e.g., "video_frames")
4. Extracts frames at regular intervals based on the specified seconds
5. Names each output file with the original filename followed by a sequential number (e.g., "video_0001.png", "video_0002.png")
6. Provides progress feedback during extraction
7. Outputs a summary when complete
You can run it like:

  ./v2i.sh video.mp4 5
</pre>
