# MuseScore to DARMS export plugin
## Compatibility
The plugin on this page was developed for MuseScore 3.X and adapted for version 4.X.
The plugin has been tested on MacOs and Windows

## What can you do
The "MuseScore to DARMS export plugin" allows you to export a score generated in MuseScore into the DARMS language.
DARMS is a language for the alphanumeric representation of music score. You can find a manual at URL: https://esf.ccarh.org/ccarh-wiki/DARMS-1976.pdf 

The implementation allows you to:
1. Export musical instruments information
2. Export the time signature information
3. Export the key information
4. Export the height information
5. Export the duration information
6. Export the information about overlapping voices
7. Export the information about tuplet
8. Export musical bar line information
9. Export musical beam information
10. You will also be able to select the type of DARMS suppression thanks the graphical interface

Note that:
- Tuplets are coded correctly only if they are made up of notes of the same duration
- Only the first musical key of each pentagram relating to each instrument is encoded. Any other musical keys in the score are ignored. Exporting a score consisting only of rests does not allow the identification of the musical key.
- Overlapping voices are not encoded correctly if they do not persist for the entire score (from the first measure to the last)
- Some duration code may not have been encoded
- Some barline may not have been encoded

The export takes place to a text file (.txt) which you can indicate and place using the graphical interface.

### Changelog
03/2024 Created version 1.0 (this one)

## How to use plugin
You can use plugin follow the instruction in this URL:
- For MuseScore 3.X : https://musescore.org/en/handbook/3/plugins#installation
- For MuseScore 4.X: https://musescore.org/en/handbook/4/plugins#installation 

## License
MuseScore to DARMS export plugin Adragna Vincenzo - vincenzo.adragna@studenti.unimi.it

This program is free software: the plugin is based in some aspects on the "IEEE 1599 Export for Musescore 3.x" (Avaibe at URL: https://musescore.org/en/project/ieee-1599-export-musescore-3x) distributed under the GNU 3 license. For This reason, also this plugin is distributed under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

## Screenshot
![image](https://github.com/vincead/MuseScore/assets/72557708/ed31f44f-b41e-4817-b3d6-78cbc78d7cb3)
![image](https://github.com/vincead/MuseScore/assets/72557708/98753279-5e9c-4357-b420-e9e374edb613)

