import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import MuseScore 3.0
import QtQuick.Dialogs 1.2
import Qt.labs.settings 1.0


// per navigazione directory
import Qt.labs.folderlistmodel 2.1
// per scrittura
import FileIO 3.0

MuseScore {
	menuPath: "Plugins.Plugin per l'esportazione da MuseScore a DARMS"
	description: "Plugin per l'esportazione da MuseScore a DARMS"
	pluginType: "dialog"



// ################################################# 
// ###################### GUI ###################### 
// ################################################# 




	id: mainWindow
	width:  600
	height: 770


	// PARAMETRI DI DEFAULT
	property int grandezzaTitolo: 18
	property int grandezzaSottotitolo: 16
	property int larghezzaBottone: 80
	property int piccolaLarghezza: 150
	property int mediaLarghezza: 300
	property int grandeLarghezza: 610
	property int altezzaStandard: 30
	property int altezzaGrande: 45
	property int grandezzaFontStandard: 14
	property int grandezzaFontHeader: 24
	property int dimensioneRaggio: 10
	property string coloreTitolo: "#3399ff"
	property string coloreSottotitolo: "#003d99"
	property string coloreBottone: "white"
	property string coloreHeaderFooter: "lightgray"
	property string coloreExportDirectory: "#ff0000"
	property string coloreExportDirectoryInLine: "#75a3a3"



	Rectangle {
		id: header
		width: mainWindow.width
		height: 80
		color: coloreHeaderFooter
		anchors.top: mainWindow.top

		Label {
			text: "MuseScore to Darms export plugin"
			font.pixelSize: grandezzaFontHeader
			font.weight: Font.Bold

			anchors.centerIn: parent
		}
	}

	Label {
		id: globalTitle
		text: "\nExport Settings\n"

		color: coloreTitolo
		font.pixelSize: grandezzaTitolo
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		width: grandeLarghezza
		height: altezzaGrande

		anchors.top: header.bottom
		anchors.topMargin: 20

	}


	Label {
		id: labelSpacerTitle
		text: ""
		font.pixelSize: grandezzaFontStandard
		width: piccolaLarghezza
		height: altezzaGrande
		horizontalAlignment: Text.AlignRight
		verticalAlignment: Text.AlignVCenter

	}

	Label {
		id: labelTitle
		text: "Name and Path"
		color: coloreSottotitolo
		font.pixelSize: grandezzaSottotitolo
		anchors.left: labelSpacerTitle.right
		anchors.top: globalTitle.bottom
		width: piccolaLarghezza
		height: altezzaGrande
		verticalAlignment: Text.AlignVCenter
	}





	// NOME FILE
	Label {
		id: labelTextFieldTitle
		text: "File name  "
		font.pixelSize: grandezzaFontStandard
		anchors.top: labelTitle.bottom;
		width: piccolaLarghezza
		height: altezzaStandard
		horizontalAlignment: Text.AlignRight
		verticalAlignment: Text.AlignVCenter
	}


	TextField {
		id: textFieldTitle
		font.pixelSize: grandezzaFontStandard
		placeholderText: "You need to set a name"

		text: curScore.title + "_Darms"
		anchors.top: labelTitle.bottom;
		anchors.left: labelTextFieldTitle.right;
		width: mediaLarghezza
		height: altezzaStandard
	}


	Button {
		id: buttonFileTitle
		text: "⌫ Clear"
		anchors.top: labelTitle.bottom;
		anchors.left: textFieldTitle.right;
		width: larghezzaBottone
		height: altezzaStandard
		anchors.leftMargin:5

		background: Rectangle {
			color: coloreBottone  
			radius: dimensioneRaggio
		}

		MouseArea {
			anchors.fill: parent
			onClicked: textFieldTitle.text = ""
		}

	}



    // PATH

	Label {
		id: labelPath
		text: "File path  "
		font.pixelSize: grandezzaFontStandard
		anchors.top: labelTextFieldTitle.bottom;
		width: piccolaLarghezza
		height: altezzaStandard
		horizontalAlignment: Text.AlignRight
		verticalAlignment: Text.AlignVCenter
	}

	TextField {
		id: exportDirectory
		anchors.top: labelTextFieldTitle.bottom
		anchors.left: labelPath.right
		anchors.topMargin:5
		placeholderText: "PATH NOT SELECTED YET"
		color: coloreExportDirectory
		width: mediaLarghezza
		height: altezzaStandard
		enabled: false
	}

	FileDialog {
		id: directorySelectDialog
		title: qsTranslate("MS::PathListDialog", "Choose a directory")

		selectFolder: true

		visible: false

		onAccepted: {
			exportDirectory.text = this.folder.toString().replace("file://", "").replace(/^\/(.:\/)(.*)$/, "$1$2");
			exportDirectory.color = coloreExportDirectoryInLine
		}

	}

	Button {
		id: selectDirectory
		width: larghezzaBottone
		height: altezzaStandard
		anchors.left: exportDirectory.right
		anchors.top: textFieldTitle.bottom
		anchors.leftMargin:5
		anchors.topMargin:5
		text: "📂"


		background: Rectangle {
			color: coloreBottone  
			radius: dimensioneRaggio  
		}

		onClicked: {
			directorySelectDialog.open();
		}

	}


	// DARMS SETTINGS

	Label {
		id: labelDARMSSet
		text: "Darms Settings"
		color: coloreTitolo
		font.pixelSize: grandezzaTitolo

		anchors.top: labelPath.bottom
		anchors.topMargin: 20
		width: grandeLarghezza
		height: altezzaGrande
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
	}

	Label {
		id: labelSpacerRadio
		text: ""
		font.pixelSize: grandezzaFontStandard
		width: piccolaLarghezza
		height: altezzaGrande
		horizontalAlignment: Text.AlignRight
		verticalAlignment: Text.AlignVCenter
	}

	Label {
		id: labelRadio
		text: "What kind of suppression do you want to apply?"
		color: coloreSottotitolo
		font.pixelSize: grandezzaSottotitolo

		horizontalAlignment: Text.AlignRight
		verticalAlignment: Text.AlignVCenter

		height: altezzaGrande

		anchors.left: labelSpacerRadio.right
		anchors.top: labelDARMSSet.bottom

	}


	RadioButton {
		id: radioNoSuppr
		text: "No suppression"
		anchors.left: labelRadio.left
		anchors.top: labelRadio.bottom
		anchors.leftMargin: 10
		anchors.topMargin: 10
		checked: false
	}

	RadioButton {
		id: radioTwoSuppr
		text: "Only Two Suppression"
		anchors.left: radioNoSuppr.left
		anchors.top: radioNoSuppr.bottom
		checked: false
	}

	RadioButton {
		id: radioSigmaSuppr
		text: "Only Sigma Suppression"
		anchors.left: radioTwoSuppr.left
		anchors.top: radioTwoSuppr.bottom
		checked: false
	}

	RadioButton {
		id: radioBoth
		text: "Two Suppression & Sigma Suppression"
		anchors.left: radioSigmaSuppr.left
		anchors.top: radioSigmaSuppr.bottom
		checked: true
	}



	MessageDialog {
		id: endDialog
		visible: false
		title: qsTr("Conversion performed")
		text: "Score has been successfully created"

		// Compatibilità MuseScore 4
		onAccepted: {
			(typeof(quit) === 'undefined' ? Qt.quit : quit)()
		}

		function openEndDialog(message) {
			text = message
			open()
		}
	}


	MessageDialog {
		id: errorDialog
		visible: false
		title: qsTr("Error")
		text: "Error"

		onAccepted: {
			close()
		}

		function openErrorDialog(message) {
			text = message
			open()
		}
	}






	Rectangle {
		id: bottoni
		width: mainWindow.width
		anchors.top: radioBoth.bottom
		anchors.left: mainWindow.left
		anchors.topMargin: 30
		anchors.leftMargin: 180

		RowLayout {
			spacing: 85

			Button {
				id: buttonCreate
				text: "✓ Create"
				background: Rectangle {
					color: "#ccff99"
					radius: dimensioneRaggio
				}

				width: larghezzaBottone
				height: altezzaStandard

				onClicked: {
					// CREO IL FILE
					createTxtFile()
				}
			}


			Button {
				id: buttonClose
				text: "✕ Close"
				background: Rectangle {
					color: "#ff6666"
					radius: dimensioneRaggio
				}

				width: larghezzaBottone
				height: altezzaStandard

				// Compatibilità MuseScore 4
				onClicked: {
					(typeof(quit) === 'undefined' ? Qt.quit : quit)()
				}

			}
		}
	}



	Rectangle {
		id: footer
		width: mainWindow.width
		height: mainWindow.height * 0.20
		color: coloreHeaderFooter
		anchors.top: bottoni.bottom
			  anchors.topMargin: 60
		Label {
			text: "\nThis plugin was created as part of a three-year thesis in\n\"Informatica Musicale\"(University of Milan)\n\nFor any support it is advisable to contact the developer (Adragna Vincenzo) at:\n vincenzo.adragna\@studenti.unimi.it "
			anchors.centerIn: parent
		}
	}





// ################################################# 

// ################# FILE CREATION ################# 

// ################################################# 


	FileIO {
		id: txtWriter
		onError: console.log(msg + "  Filename = " + txtWriter.source)
	}

	
	function createTxtFile() {

		// controllo nome file e directory
		if (!textFieldTitle.text) {
			errorDialog.openErrorDialog(qsTr("File name not specified"))
			return
		} else if (!exportDirectory.text) {
			errorDialog.openErrorDialog(qsTr("File folder not specified"))
			return
		}

		var TestoFile = "K [MUSESCORE TO DARMS PLUGIN] TITLE: " + curScore.title + " $\n"
		TestoFile += "K [MUSESCORE TO DARMS PLUGIN] DARMS traduction generated using "
		
		switch (true) {
			case radioNoSuppr.checked:
				TestoFile += "no suppression."
				break 
			case radioTwoSuppr.checked:
				TestoFile += "only two suppression."
				break 
			case radioSigmaSuppr.checked:
				TestoFile += "only sigma suppression."
				break
			case radioBoth.checked:
				TestoFile += "two suppression and sigma suppression."
				break
	
		}

		TestoFile += " $\n"


		// chiamo Funzione che permette di creare la traduzione in DARMS e restituisce
		// il testo tradotto
		TestoFile += createDARMS()


		var nomeFile =  exportDirectory.text + "/" + textFieldTitle.text + ".txt"
		console.log("Export to " + nomeFile)
		txtWriter.source = nomeFile
		console.log("Writing Txt...")

		// inserisco il testo
		txtWriter.write(TestoFile)
		console.log("writed")
		endDialog.open()
	}



// ################################################# 

// #################### FUNCTION ###################

// ################################################# 




	// it is used for clef, it returns the note name based on tcp of note in input
	function getNomeNota(note) {
		var tpc = note.tpc1
		switch (tpc % 7) {
			case 0:
				return "C"
			case 2:
				return "D"
			case 4:
				return "E"
			case 6:
				return "F"
			case -1:
				return "F"
			case 1:
				return "G"
			case 3:
				return "A"
			case 5:
				return "B"
		}
		return "none"

	}

	// it find initial clef for the staff in input
	function getChiave(pentagramma){
		var tutteLeNote = ["C", "D", "E", "F", "G", "A", "B"]
		var chiaveSOL = {};
		var ultimaNotaChiaveSOL = 6;

		var chiaveFA = {};
		var ultimaNotaChiaveFA = 4;

		var chiaveFA3 = {};
		var ultimaNotaChiaveFA3 = 2;

		var chiaveDO1 = {};
		var ultimaNotaChiaveDO1 = 1;

		var chiaveDO2 = {};
		var ultimaNotaChiaveDO2 = 3;

		var chiaveDO3 = {};
		var ultimaNotaChiaveDO3 = 5;

		var chiaveDO4 = {};
		var ultimaNotaChiaveDO4 = 0;

		var posizione = -12.5
		
		// CREO ARRAY DELLE CHIAVI:
		for (var i = 0; i < 72; i += 1) {
			chiaveSOL[posizione] = tutteLeNote[6-ultimaNotaChiaveSOL]
			if (ultimaNotaChiaveSOL == 6) {
				ultimaNotaChiaveSOL = 0
			} else {
				ultimaNotaChiaveSOL += 1
			}

			chiaveFA[posizione] = tutteLeNote[6-ultimaNotaChiaveFA]
			if (ultimaNotaChiaveFA == 6) {
				ultimaNotaChiaveFA = 0
			} else {
				ultimaNotaChiaveFA += 1
			}

			chiaveFA3[posizione] = tutteLeNote[6-ultimaNotaChiaveFA3]
			if (ultimaNotaChiaveFA3 == 6) {
				ultimaNotaChiaveFA3 = 0
			} else {
				ultimaNotaChiaveFA3 += 1
			}

			chiaveDO1[posizione] = tutteLeNote[6-ultimaNotaChiaveDO1]
			if (ultimaNotaChiaveDO1 == 6) {
				ultimaNotaChiaveDO1 = 0
			} else {
				ultimaNotaChiaveDO1 += 1
			}

			chiaveDO2[posizione] = tutteLeNote[6-ultimaNotaChiaveDO2]
			if (ultimaNotaChiaveDO2 == 6) {
				ultimaNotaChiaveDO2 = 0
			} else {
				ultimaNotaChiaveDO2 += 1
			}

			chiaveDO3[posizione] = tutteLeNote[6-ultimaNotaChiaveDO3]
			if (ultimaNotaChiaveDO3 == 6) {
				ultimaNotaChiaveDO3 = 0
			} else {
				ultimaNotaChiaveDO3 += 1
			}

			chiaveDO4[posizione] = tutteLeNote[6-ultimaNotaChiaveDO4]
			if (ultimaNotaChiaveDO4 == 6) {
				ultimaNotaChiaveDO4 = 0
			} else {
				ultimaNotaChiaveDO4 += 1
			}

			posizione += 0.5
		}


		var myCursor = curScore.newCursor()
		myCursor.staffIdx = pentagramma
		myCursor.rewind(0)

		do {
			// QUANDO TROVO UN ACCORDO
			if (myCursor.element.type == Element.CHORD) {
				// SE SI PUO' DEFINIRE UN PITCH
				if (curScore.parts[0].hasPitchedStaff) {
					var note = myCursor.element.notes[0]
					var position = Math.round(note.posY * 10) /10

					switch (getNomeNota(note)) {
						// 3 possibilità se rientra nell'array chiaveSOL: chiave di SOL, chiave di Sol 8va sotto o
						// chiave di Fa su linea 5  (subbasso)
						case chiaveSOL[position]:
							if (position <= 15.5 && position >= 12.5) {
								switch (getOctave(note)) {
									case 2:
										return "!G"
									case 1:
										return "!G-8"
									case 0:
										return "9!F"
								}
							} else if (position <= 12 && position  >= 9) {
								switch (getOctave(note)) {
									case 3:
										return "!G"
									case 2:
										return "!G-8"
									case 1:
										return "9!F"
								}

							} else if (position <= 8.5 && position  >= 5.5) {
								switch (getOctave(note)) {
									case 4:
										return "!G"
									case 3:
										return "!G-8"
									case 2:
										return "9!F"
								}
							} else if (position <= 5 && position  >= 2) {
								switch (getOctave(note)) {
									case 5:
										return "!G"
									case 4:
										return "!G-8"
									case 3:
										return "9!F"
								}
							} else if (position <= 1.5 && position  >= -1.5) {
								switch (getOctave(note)) {
									case 6:
										return "!G"
									case 5:
										return "!G-8"
									case 4:
										return "9!F"
								}
							} else if (position <= -2 && position >= -5 ) {
								switch (getOctave(note)) {
									case 7:
										return "!G"
									case 6:
										return "!G-8"
									case 5:
										return "9!F"
								}
							} else if (position <= -5.5 && position >= -8.5 ) {
								switch (getOctave(note)) {
									case 8:
										return "!G"
									case 7:
										return "!G-8"
									case 6 :
											return "9!F"
								}
							} else if (position <= -9 && position >= -12 ) {
								switch (getOctave(note)) {
									case 8:
										return "!G-8"
									case 7:
										return "9!F"
								}
							}

							return ""

							// Due soluzioni: chiave di FA o violino francese
							case chiaveFA[position]:
								if (position <= 16 && position  >= 13) {
									switch (getOctave(note)) {
										case 3:
											return "1!G"
										case 0:
											return "!F"
									}
								} else if (position <= 12.5 && position  >= 9.5) {
									switch (getOctave(note)) {
										case 4:
											return "1!G"
										case 1:
											return "!F"
									}
								} else if (position <= 9 && position  >= 6) {
									switch (getOctave(note)) {
										case 5:
											return "1!G"
										case 2:
											return "!F"
									}
								} else if (position <= 5.5 && position  >= 2.5) {
								   switch (getOctave(note)) {
										case 6:
											return "1!G"
										case 3:
											return "!F"
									}
								} else if (position <= 2 && position >= -1 ) {
									switch (getOctave(note)) {
										case 7:
											return "1!G"
										case 4:
											return "!F"
									}
								} else if (position <= -1.5 && position >= -4.5 ) {
									switch (getOctave(note)) {
										case 8:
											return "1!G"
										case 5:
											return "!F"
									}
								} else if (position <= -5 && position >= -8 ) {
								   switch (getOctave(note)) {
										case 9:
											return "1!G"
										case 6:
											return "!F"
									}
								} else if (position <= -8.5 && position >= -11.5 ) {
								   switch (getOctave(note)) {
										case 10:
											return "1!G"
										case 7:
											return "!F"
									}
								} else {
									return "!F"
								}

								return "None"

								case chiaveFA3[position]:
									// caso Chiave di Do su 3a linea / chiave di baritono
									// sono indistinguibili purtroppo: hanno stesse altezze
									return "5!F"
								case chiaveDO1[position]:
									return "1!C"
								case chiaveDO2[position]:
									return "3!C"
								case chiaveDO3[position]:
									return "!C"
								case chiaveDO4[position]:
									return "7!C"
								default:
									return ""
					}



					return ""
				}
			}
		} while (myCursor.next())

		return "K Clef undefined $"
	}



	function getTimeSignature(stato) {
		var res = "!M"
		var cursor = curScore.newCursor()
		var segment = curScore.firstSegment ();

		do {
			var element = segment.elementAt(0)
			if (segment.segmentType == 0x10) {
				if (element.timesigType == 1) {
							res += "C "
							stato.chiaveDur=1
				} else if (element.timesigType == 2) {
							res += "C/ "
							stato.chiaveDur=0.5
				} else {
							if (element.numeratorString) {
								res += element.numeratorString +":"
								res += element.denominatorString + " "
								stato.chiaveDur=element.numeratorString/element.denominatorString 
							} else {
								res += element.timesig.numerator + ":"
								res += element.timesig.denominator + " "
								stato.chiaveDur= element.timesig.numerator / element.timesig.denominator
							}
				}
				return res
			}
			segment = segment.next

			if (!segment) {
				break
			}
		} while (segment)
		// non ho trovato un metro
	return "K Metro undefined $"
	}





	function getOctave(note) {
		var octave = note.pitch / 12
		if (note.tpc == 0 || note.tpc == 7)
			octave++
		if (note.tpc == 26 || note.tpc == 33)
			octave--
		return Math.floor(octave)
	}


	function getActualAccidental(note) {
			if (note.accidentalType == 1) {
				//b
				return "-"
			} else if (note.accidentalType == 5) {
				//bb
				return "--"
			} else if (note.accidentalType == 3) {
				//#
				return "#"
			} else if (note.accidentalType == 4) {
				//##
				return "##"
			} else if (note.accidentalType == 2) {
				//beq
				return "*"
			} else {
				return ""
			}
				
				
	}








	function notaPosition(curElement) {
		// CICLO SULL'ACCORDO
		var numNoteInAccordo = curElement.notes.length
		var txt = ""
		var numNota = 0;

		// CICLO SULL'ACCORDO
		for (var i = 0; i < numNoteInAccordo; i++) {
			if (numNoteInAccordo > 1){
				txt += "|"
			}

			var note = curElement.notes[i]
			var position = Math.round(note.posY * 10) /10

			// VALIDO PER TUTTI(uso posizione relativa):

			numNota = 29 - (2 * position)


			// controllo soppressione del 2 e gestisco di conseguenza
			if (radioTwoSuppr.checked || radioBoth.checked) {
				// --- SE LO CHIEDE L'UTENTE
				if (numNota >= 20 && numNota <= 29) {
					  numNota = numNota - 20
				} else if (numNota <= 9) {
					  txt += "0"
				}
			}
			txt += numNota 


			// Inserisco Alterazione
			txt += getActualAccidental(curElement.notes[i])
			



			// Vedo se c'è legatura di valore
			if (numNoteInAccordo > 1 && curElement.notes[i].tieForward) {
				txt += "J"
			}

		}

		// inserisco l'ultimo |
		if (numNoteInAccordo > 1) {
			  txt += "|"
		}


		var res = [numNota, txt]
		return res
	}



	function duration(dur) {
		switch (dur) {
			case ((16/4) + (8/4) + (4/4)):
				// long ..
				return "WWW.."
			case ((16/4) + (8/4)):
				// long .
				return "WWW."
			case (16/4):
				// long
				return "WWW"
			case ((8/4) + (4/4) + (2/4)):
				// breve ..
				return "WW.."
			case ((8/4) + (4/4)):
				// breve .
				return "WW."
			case (8/4):
				// breve
				return "WW"
			case ((4/4) + (2/4) + (1/4)):
				// semibreve ..
				return "W.."
			case ((4/4) + (2/4)):
				// semibreve .
				return "W."
			case (4/4):
				// semibreve
				return "W"
			case ((2/4) + (1/4) + (1/8)):
				// half ..
				return "H.."
			case ((2/4) + (1/4)):
				// half .
				return "H."
			case (2/4):
				//half
				return "H"
			case ((1/4) + (1/8) + (1/16)):
				// quarter ..
				return "Q.."
			case ((1/4) + (1/8)):
				// quarter .
				return "Q."
			case (1/4):
				// quarter
				return "Q"
			case ((1/8) + (1/16) + (1/32)):
				// eight ..
				return "E.."
			case ((1/8) + (1/16)):
				// eight .
				return "E."
			case (1/8):
				// eight
				return "E"
			case ((1/16) + (1/32) + (1/64)):
				// sixteenth ..
				return "S.."
			case ((1/16) + (1/32)):
				// sixteenth .
				return "S."
			case (1/16):
				// sixteenth
				return "S"
			case ((1/32) + (1/64) + (1/128)):
				// Thirty-second ..
				return "T.."
			case ((1/32) + (1/64)):
				// Thirty-second .
				return "T."
			case (1/32):
				// Thirty-second
				return "T"
			case ((1/64) + (1/128) + (1/256)):
				// sixty-fourth ..
				return "X.."
			case ((1/64)+(1/128)):
				// sixty-fourth .
				return "X."
			case (1/64):
				// sixty-fourth
				return "X"
			case ((1/128)+ (1/256) + (1/512)):
				// 128th ..
				return "Y.."
			case ((1/128)+ (1/256)):
				// 128th .
				return "Y."
			case (1/128):
				// 128th
				return "Y"
			case ((1/256)+ (1/512) + (1/1024)):
				// 128th ..
				return "Z.."
			case ((1/256)+ (1/512)):
				// 128th .
				return "Z."
			case (1/256):
				// 128th
				return "Z"
			default:
				return "ND"
		}
	}


	/* QUESTA FUNZIONE GESTISCE LA BARLINE */
	function tipoBarra (bar) {


		if (bar == 1) {
			// BARLINE NORMAL / SINGLE
			return "/"
		} else if (bar == 0x20) {
			// BARLINE END
			return "/!/"
		} else if (bar == 2) {
			// BARLINE DOUBLE
			return "//"
		} else if (bar == 4) {
			//START_REPEAT
			return "!//:"
		} else if (bar == 8) {
			//END_REPEAT
			return ":/!/"
		} else {
			return ""
		}
	}



	function contaNumeroVoci(cursor){
		var numVoci = 0;
		for (var i = 0; i < 4; i++) {
			cursor.voice = i
			cursor.rewind(0)

			if (cursor.element == null) {
					continue
			}
			numVoci += 1
		}

		return numVoci;
	}


	function gestisciInizioMultiStrumentoOMultiPentagramma(cursorPent, nS, nP, nPTot, pentagramma) {
		
		var res = "\n\nK Begin ";
		// add comment
		res+= cursorPent.score.parts[nS-1].longName + " staff " + nP + " of " + nPTot + " $\n"
		
		if (nP == 1) {
			res += "!I"+nS
			res += " "
		}
		
		return res

		
	}



	function rilevaStanghette() {
		var stanghette = [];
		var seg = curScore.firstSegment();
		do {
			var isBarLine = !!(Segment.BarLineType & seg.segmentType);
			if (isBarLine && seg.segmentType != Segment.BeginBarLine)
			{
				var stanghettaTrovata = tipoBarra(seg.elementAt(0).barlineType)
				if (seg.segmentType == Segment.StartRepeatBarLine) {
					stanghette.pop()
				}
				stanghette.push(stanghettaTrovata)
				
			}
			seg = seg.next;
		} while (seg.next)
		
		var lastbar = 0
		var numBattute = 0
		var cursor1 = curScore.newCursor()
		cursor1.rewind(0)
		do {
			numBattute+=1
			var segment = cursor1.measure.lastSegment;
			var bar = segment.elementAt(0);
			var lastbar = bar.barlineType
		}
		while (cursor1.nextMeasure())

		stanghette.push(tipoBarra(lastbar))
		
		var iniziaConStanghetta = !(numBattute == stanghette.length)

		var res = [iniziaConStanghetta, stanghette]
		return  res
	}





// ################################################# 

// ################### CODE TEXT  ##################

// ################################################# 



	function createDARMS() {

		// ESEGUO CODICE
		var funzioneStanghette = rilevaStanghette();
		var testoDelFile = ""
		var numeroGlobaleTuplet = 0

		var stato = {
			battuta: "undefined",
			durata: "",
			numeroNota: "",
			numeroDiTravi : 0, // INDICA IL NUMERO DI TRAVI (PRIMARIA + SECONDARIE)
			traveBbox : "",
			trave: false, // INDICA SE C'ERA TRAVE -> true = c'è trave
			durataPrecedInTrave : 0, // INDICA IL VALORE PRECEDENTE NELLA TRAVE
			stanghetta: 0,
			durataPreced: 0,
			min2voice: false,
			piuVociInit: false,
			chiaveDur:0,
			numeroStrumento:0,
			numeroPentagrammaStrumento: 1,
			numPentagrammiPerStrumento: 1
		}



		
		var altraBattuta = 0
		var cursor = curScore.newCursor()

		// PER OGNI PENTAGRAMMA
		for (var p = 0; p < curScore.nstaves; p++) {
			//testoDelFile += "\n\n====== PENTAGRAMMA " + (p+1) + " =======\n\n "
			if (stato.numPentagrammiPerStrumento - stato.numeroPentagrammaStrumento == 0) {
				stato.numPentagrammiPerStrumento=(cursor.score.parts[stato.numeroStrumento].endTrack  - cursor.score.parts[stato.numeroStrumento].startTrack)/4

				stato.numeroStrumento += 1
				stato.numeroPentagrammaStrumento = 0
			} 
			
			stato.numeroPentagrammaStrumento += 1

			
			testoDelFile += gestisciInizioMultiStrumentoOMultiPentagramma(cursor, stato.numeroStrumento, stato.numeroPentagrammaStrumento, stato.numPentagrammiPerStrumento, p);

			if (stato.numeroPentagrammaStrumento == 1) {
				for (var penta = 0; penta < stato.numPentagrammiPerStrumento; penta++) {
					
					if (penta != 0 && stato.numPentagrammiPerStrumento >= 2) {
						testoDelFile += ','
					}
					
					testoDelFile +=  getChiave(p + penta) + " "
				}
				
				if (stato.numPentagrammiPerStrumento >= 2) {
					testoDelFile += '\n'
				}
			}
			
			testoDelFile += getTimeSignature(stato)
			testoDelFile += " !K"+ curScore.keysig + "   "
			
			cursor.staffIdx = p
			stato.min2voice = false;

			var numVoci = 0;

			numVoci = contaNumeroVoci(cursor)
			

			// ci sono più voci sovrapposte (es. corale)
			if (numVoci > 1) {
				stato.min2voice = true;
				testoDelFile +=  "!& "
			}
		
			// PER OGNI VOCE
			for (var i = 0; i < 4; i++) {
				
				//testoDelFile += "\n\n===== VOCE " + (i + 1) + "=====\n\n"
				cursor.voice = i
				cursor.rewind(0)
				var tuplet = false; // indica la presenza o meno di un gruppo irregolare
				var numNotaIrregolare = 0
				var durInserita = false;
				var NumNotainsert = false;
				stato.stanghetta = 0;

				if (cursor.element == null) {
					continue
				}

				// se ci sono più voci chiudo quella precedente
				if (i >= 1)    {
					testoDelFile +=  "\n&  ";
				}

				var numBattuta = 1

				//testoDelFile += "\n\n===== BATTUTA " + numBattuta + "=====\n\n"

				// inizializzo battuta
				stato.battuta = cursor.measure.bbox

				
				do {
					
					var curElement = cursor.element
					NumNotainsert = false;
					// GESTISCO LA BARLINE
					// se il pezzo inizia con una stanghetta
					if (funzioneStanghette[0] && stato.stanghetta == 0) {
						testoDelFile += funzioneStanghette[1][0] + " "
						stato.stanghetta += 1
					}
					//skip controllo successivo su Pausa di intera battuta
					var skip = false

					
					// se è cambiata la battuta
					if(cursor.measure.bbox != stato.battuta) {
						//se c'era trave
						if (stato.durataPrecedInTrave != 0) {
							//chiudo la travatura
							for (var l=0; l < stato.numeroDiTravi; l++) {
									  testoDelFile += ")"
							}
							testoDelFile += " "

							//reset valori iniziali di trave
							stato.trave = false
							stato.numeroDiTravi = 0
							//reset valori iniziali
							stato.durataPrecedInTrave = 0
							stato.durataPreced = 0
						}

						stato.battuta = cursor.measure.bbox

						// inserisco la stanghetta
						
						testoDelFile += funzioneStanghette[1][stato.stanghetta] + " "
						stato.stanghetta += 1
						
						// incremento la battuta
						numBattuta += 1
						//testoDelFile += "\n\n===== BATTUTA " + numBattuta + "=====\n\n"
						skip = true
					}


					// GESTISCO DURATA NOTA
					// prendo in considerazione elementi che MuseScore mi fornisce

					stato.durata = curElement.duration.numerator / curElement.duration.denominator

					//gestione battuta di intera pausa
					if (curElement.type == Element.REST && !skip && numBattuta!=1) {
						if (stato.chiaveDur <=stato.durata ) {

							testoDelFile += funzioneStanghette[1][stato.stanghetta] + " "
							stato.stanghetta += 1
							numBattuta += 1
							//testoDelFile += "\n\n===== BATTUTA " + numBattuta + "=====\n\n"
						}
						
					}

					


					// ------ GESTIONE TRAVE START

					// SE LA NOTA HA LA TRAVE
					if (curElement.beam) {
						
						// CONTROLLO CHE NON SIA CAMBIATA
						if (curElement.beam.bbox != stato.traveBbox) {
							// SE SONO QUI E' CAMBIATA => DEVO APRIRE QUELLA NUOVA MA PRIMA CHIUDERE QUELLA VECCHIA

							// CHIUDO QUELLA VECCHIA SE C'E'
							if (stato.trave) {
								for (var k=0; k< stato.numeroDiTravi; k++) {
									testoDelFile += ")"
								}
								stato.numeroDiTravi = 0;
							}


							// APRO QUELLA NUOVA
							stato.traveBbox = curElement.beam.bbox
							stato.trave = true
							if (stato.durata <= 1/128) {
								testoDelFile += "((((("
								stato.numeroDiTravi = 5
							} else if (stato.durata <= 1/64) {
								testoDelFile += "(((("
								stato.numeroDiTravi = 4
							} else if (stato.durata <= 1/32) {
								testoDelFile += "((("
								stato.numeroDiTravi = 3
							} else if (stato.durata <=  1/16) {
								testoDelFile += "(("
								stato.numeroDiTravi = 2
							} else {
								testoDelFile += "("
								stato.numeroDiTravi = 1
							}



							// memorizzo valore corrente che divverà il precedente per la nota successiva
							stato.durataPrecedInTrave = stato.durata

						} else if (curElement.beam.bbox == stato.traveBbox) {
							// SE SONO QUI NON E' CAMBIATA LA TRAVE!


							// VERIFICO IL VALORE DELLA NOTA CORRENTE RISPETTO AL PRECEDENTE PER CAPIRE SE AGGIUNGERE
							// TRAVI SECONDARIE

							// caso 1: valore precedente > di quello corrente       es 1/8 > 1/16
							if ( stato.durataPrecedInTrave > stato.durata) {
								// dovrò aprire delle travi -> controllo di quante ne necessito
								var traviNecessarie = 0
								if (stato.durata <= 1/128) {
									traviNecessarie = 5
								} else if (stato.durata <= 1/64) {
									traviNecessarie = 4
								} else if (stato.durata <= 1/32) {
									traviNecessarie = 3
								} else if (stato.durata <=  1/16) {
									traviNecessarie = 2
								} else {
									traviNecessarie = 1
								}

								for (k = 0; k <  traviNecessarie - stato.numeroDiTravi ; k++) {
									testoDelFile += "("
								}
								// aggiorno numero di travi nella travatura corrente
								stato.numeroDiTravi = traviNecessarie



							// caso 2: valore precedente < di quell corrente es   1/16 < 1/8
							} else if (stato.durataPrecedInTrave < stato.durata) {
								// dovrò chiudere delle travi -> controllo di quante ne necessito
								var traviNecessarie = 0
								if (stato.durata <= 1/128) {
									traviNecessarie = 5
								} else  if (stato.durata <= 1/64) {
									traviNecessarie = 4
								} else if (stato.durata <= 1/32) {
									traviNecessarie = 3
								} else if (stato.durata <=  1/16) {
									traviNecessarie = 2
								} else {
									traviNecessarie = 1
								}

								for (var k = 0; k < stato.numeroDiTravi -  traviNecessarie  ; k++) {
									testoDelFile += ")"
								}
								stato.numeroDiTravi = traviNecessarie
								//testoDelFile +=  "=> numero travi: " + stato.numeroDiTravi + " => travi necessarie: " +  traviNecessarie + "=> stato.numeroDiTravi -  traviNecessarie " + (stato.numeroDiTravi -  traviNecessarie)

							}


							stato.durataPrecedInTrave = stato.durata

						}

						// SE C'ERA STATA LA TRAVE FINO A PRIMA DEVO CHIUDERLA!!
					} else if (stato.durataPrecedInTrave != 0) {

						for (var l=0; l < stato.numeroDiTravi; l++) {
							testoDelFile += ")"
						}
						
						testoDelFile += " "
						stato.trave = false
						stato.durataPrecedInTrave = 0
						stato.durataPreced = 0
						stato.numeroDiTravi = 0;


					} else {
						// LA NOTA NON HA LA TRAVE
						stato.trave = false
						stato.durataPrecedInTrave = 0
						stato.durataPreced = 0
					}

					//-------------- GESTIONE TRAVE END
					
					
					
					
					// CONTROLLO SE E' UN GRUPPO IRREGOLARE

					if (curElement.tuplet != null || tuplet) {
						
						if (numNotaIrregolare == 0) {
							tuplet = true
							numeroGlobaleTuplet +=1
							var durata = duration(curElement.duration.numerator / curElement.duration.denominator);
							testoDelFile += "!"+ curElement.tuplet.elements.length+""+ durata  + ""

							var elemBase = (curElement.tuplet.elements.length * (curElement.duration.numerator / curElement.duration.denominator))/curElement.tuplet.actualNotes;


							var stringDurataElemBase = duration(elemBase);

							// calcolo quanti elementiBase ci sono nella durata totale 
							var numElemBaseInTot = 0;

							for (var totDurata = 0; totDurata < curElement.tuplet.duration.numerator / curElement.tuplet.duration.denominator; totDurata += elemBase) {
								numElemBaseInTot += 1;
							}

							testoDelFile += numeroGlobaleTuplet + ":" + numElemBaseInTot + stringDurataElemBase + " ";

						}
						// mi segno che la prima nota l'ho processata
						numNotaIrregolare += 1

					}
					
					
					
					
					
					
					

					//-------------- GESTIONE NUMERO NOTA e DURATA START

					// GESTIONE NUMERO NOTA E DURATA

					//se c'è trave
					if (stato.trave) {

						if (curElement.type == Element.CHORD) {
							// res contiene il numero dell'ultima nota e
							// il testo da inserire in testoDelFile
							var res = notaPosition(curElement)
							stato.numeroNota = res[0]
							testoDelFile += res[1]
						} else if (curElement.type == Element.REST) {
							testoDelFile += "R"
							stato.numeroNota = "R"
						}

						console.log("entro")
						var durDaCiclare = duration(stato.durata)
						for (var d = 0; d < durDaCiclare.length; d++) {
							if (durDaCiclare.charAt(d) == ".")	{
								testoDelFile += "."
							}
						}
					} else {
						//non c'è trave
						if (curElement.type == Element.CHORD) {
							// res contiene il numero dell'ultima nota e
							// il testo da inserire in testoDelFile
							var res = notaPosition(curElement)
							// verifico se c'è sigma suppression
							if (curElement.notes.length > 1 ) {
								testoDelFile += res[1]
								NumNotainsert = true;
							} else if (radioSigmaSuppr.checked || radioBoth.checked) {
								if (stato.numeroNota == res[0]) {
									// nota attuale = nota precedente
									//testoDelFile += duration(stato.durata) + " "
								} else {
									testoDelFile += res[1]
									NumNotainsert = true;
								}
							} else {
								testoDelFile += res[1]
								NumNotainsert = true;
							}
							stato.numeroNota = res[0]

						// SE E' UNA PAUSA
						}
						else if (curElement.type == Element.REST) {
							if (radioSigmaSuppr.checked || radioBoth.checked) {
								if (stato.numeroNota == "R" ) {
									//la nota è = alla precedente
								} else {
									testoDelFile += "R"
									NumNotainsert = true;
								}
							} else {
								testoDelFile += "R"
							}
							stato.numeroNota = "R"

						}


						// durata
						if ((stato.durata == stato.durataPreced && NumNotainsert == false) || stato.durataPreced == 0) {
							// mi segno che l'ho inserita e la inserisco
							var durInserita = true
							testoDelFile += duration(stato.durata)
						} 


						stato.durataPreced = stato.durata

					}


					//-------------- GESTIONE ID GRUPPO IRREGOLARE START

					if (tuplet) {
						if (durInserita == false || stato.trave) {
							testoDelFile += duration(stato.durata)
						}

						// inserisco identificatico gruppo irregolare
						testoDelFile += numeroGlobaleTuplet
					}

					//-------------- GESTIONE ID GRUPPO IRREGOLARE END

					//-------------- GESTIONE LEGATURA DI VALORE START
						if (curElement.type == Element.CHORD && curElement.notes.length == 1 && curElement.notes[0].tieForward) {
							testoDelFile += "J "
						}
					
					//-------------- GESTIONE LEGATURA DI VALORE START


					testoDelFile += " "

					

					//-------------- GESTIONE FINE GRUPPO IRREGOLARE START
					// controllo se è finito il gruppo irregolare
					if (curElement.tuplet != null || tuplet) {

						if (curElement.tuplet != null && numNotaIrregolare == curElement.tuplet.elements.length) {

							// reset parametri
							numNotaIrregolare = 0
							tuplet = false
						}
					}
					//-------------- GESTIONE FINE GRUPPO IRREGOLARE END

				}
				// faccio questo ciclo fin quando ci sono elementi
				while (cursor.next())





				//-------------- GESTIONE ULTIMA STANGHETTA START
				

				for (var k = 0; k < stato.numeroDiTravi; k++) {
					testoDelFile += ")"
				}
				
				//reset valori iniziali di trave
				stato.trave = false
				stato.numeroDiTravi = 0
				//reset valori iniziali
				stato.durataPrecedInTrave = 0
				stato.durataPreced = 0
				stato.stanghetta = 0

				testoDelFile +=  funzioneStanghette[1][funzioneStanghette[1].length - 1] + " "

				//-------------- GESTIONE ULTIMA STANGHETTA END

				
			} // fine ciclo per ogni voce...





			// INIZIO UNA GESTIONE DI FINE PARTITURA

			//-------------- GESTIONE VOCI MULTIPLE START
			// CHIUDO LE VOCI MULTIPLE SE CI SONO
			if (stato.min2voice) {
				testoDelFile +=  "$& ";
			}
			//-------------- GESTIONE VOCI MULTIPLE END


		} // fine gestione pentagramma

			return testoDelFile
	} // fine funzione createDARMS




	onRun: {
	}



	// compatibilità con MuseScore 4 
	Component.onCompleted: {
        if (mscoreMajorVersion >= 4) {
            title = qsTr("MuseScore to Darms export plugin")
            thumbnailName = "DARMS.png"
            categoryCode = "composing-arranging-tool"
        }
    }
}
