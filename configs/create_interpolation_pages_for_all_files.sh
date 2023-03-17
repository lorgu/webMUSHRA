#!/bin/bash

# Get all .wav files in configs/resources/audio/
wav_files=(configs/resources/audio/*.wav)

# Loop through each .wav file and generate a page with the filename
for file in "${wav_files[@]}"
do
  # Get just the filename without the extension
  filename=$(basename -- "$file")
  filename="${filename%.*}"

  # Append a new page to the interpolation_new.yaml file
  cat <<EOT >> interpolation_new.yaml
  - type: spatial
    id: "${filename}_page"
    name: "localization of $filename"
    content: "<li>Woher stammen die Sprecher*innen? </li> <li> Klicken Sie zuerst auf den Button, dann innerhalb, bzw entlang den Linien des Dreiecks um die Kugel zu versetzen. Wenn Sie nur eine Mischung von zwei Herkünften hören, setzen Sie den Punkt dementsprechend auf der Linie zwischen den jeweiligen Eckpunkten.</li><li> Bleiben Sie beim Setzen innerhalb des Dreiecks, bzw auf den Linien."
    framerate: 100
    roomMeasurements: [300, 300, 300]  # width, height, length
    stimuli:
        C1: "$file"
    responses:
      - type: localization
        name: locB
        label: "HIER klicken, dann Punkt setzen"
        color: 0xff5500      
        stimulus: C1    
        position: [0,50,0]
        size: 20
    views: 
      - view: top
        position: [0,50,0]
    objects: 
      - type: custom
        path: configs/resources/images/DE.dae
        position: [-30,0,-100]
        rotation: [0,0,0]
        scale: 0.6
      - type: custom
        path: configs/resources/images/AT.dae
        position: [70,0,100]
        rotation: [0,0,0]
        scale: 0.6
      - type: custom
        path: configs/resources/images/CH.dae
        position: [-130,0,100]
        rotation: [0,0,0]
        scale: 0.6
      - type: custom
        path: configs/resources/images/triangle_only.dae
        position: [0,0,540]
        rotation: [0,0,0]
        scale: 2
EOT

done

# Append the finish page to the interpolation_new.yaml file
cat <<EOT >> interpolation_new.yaml
  - type: finish
    name: Thank you
    content: Thank you for attending
    showResults: false
    writeResults: true
    questionnaire:
        - type: text
          label: name/shortname/nickname
          name: email
EOT