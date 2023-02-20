
# Declare counter
i=0
mkdir tmp
git rev-list --all | while read commit; do
  # Increment counter
  i=$((i+1))
  git checkout $commit
  # Generate unique filename using counter
  filename=$(printf "%05d.pdf" $i)
  # Force the generation of the PDF by running LaTeX multiple times
  pdflatex -halt-on-error -output-directory=tmp -interaction=nonstopmode thesis.tex & pdflatex -halt-on-error -output-directory=tmp -interaction=nonstopmode thesis.tex &  mv tmp/thesis.pdf tmp/$filename
  # Move the PDF file to the temporary directory with unique filename
 
done

# Use FFmpeg to create a video from the PDF files in the temporary directory
ffmpeg -framerate 30 -pattern_type glob -i 'tmp/*.pdf' -c:v libx264 -preset veryslow -crf 18 output.mp4

# Clean up temporary directory
