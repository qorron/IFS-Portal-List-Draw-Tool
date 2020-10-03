# IFS Portal List Draw Tool
Every first Saturday of the month I used to manually draw the portals others have found in IITC to decode the passcode. This time, I wrote a program that does that for me.

Template:
https://docs.google.com/document/d/1oh49z2-5CZFWRPleh06D7kamsWlYlQgtsE_DvUqu5iE/edit?usp=sharing
to edit select: File -> make a copy

usage:
once data has been added select: File -> Download -> Plain Text (.txt)
then:
list_to_draw_tools.pl < your_file.txt

what you get:
```
############################
### Symbol 2 is a letter ###
############################
It's a Bird…It's a Plane?
Structure: *-_*----

[{"type":"marker","latLng":{"lng":"16.381993","lat":"48.2134"},"color":"#57D600"},{"type":"polyline","color":"#43d921","latLngs":[{"lng":"16.381993","lat":"48.2134"},{"lng":"16.376293","lat":"48.21498"},{"lng":"16.371948","lat":"48.213067"}]},{"type":"marker","latLng":{"lat":"48.203605","lng":"16.377448"},"color":"#CFD200"},{"latLngs":[{"lat":"48.203605","lng":"16.377448"},{"lng":"16.382544","lat":"48.206767"},{"lat":"48.209925","lng":"16.376966"},{"lat":"48.208134","lng":"16.372052"}],"color":"#43d921","type":"polyline"},{"color":"#bbbbbb","type":"marker","latLng":{"lng":"16.376293","lat":"48.21498"}},{"type":"marker","color":"#bbbbbb","latLng":{"lng":"16.371948","lat":"48.213067"}},{"type":"marker","color":"#bbbbbb","latLng":{"lng":"16.382544","lat":"48.206767"}},{"color":"#bbbbbb","type":"marker","latLng":{"lat":"48.209925","lng":"16.376966"}},{"latLng":{"lat":"48.208134","lng":"16.372052"},"type":"marker","color":"#bbbbbb"}]
```

The first block contains the symbol number and the class you gave it. Classes can be letter, number or keyword. Each is drawn in its own color. Unknown classes are drawn in the default color. Then there is your guess.
The structure of the data describes where the gaps are. `*----` is a complete set. `*--_*---` is a set with a gap of one portal in the middle. You get the idea.
Then there is one big line of JSON data. just copy and paste it einto draw tools. The start of each polyline gats a colored marker. The color changes from green to blue so you can spot the order of the polyline segments.
