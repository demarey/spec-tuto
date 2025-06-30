"
I refer to an image (FileReference) and provide an api to acces its metadata.
"
Class {
	#name : 'SptImageMetadata',
	#superclass : 'Object',
	#instVars : [
		'file',
		'metadata'
	],
	#category : 'Spec2-Tutorial-Model',
	#package : 'Spec2-Tutorial',
	#tag : 'Model'
}

{ #category : 'examples' }
SptImageMetadata class >> example [

	^ self exampleWith: self exifOuputExample
]

{ #category : 'examples' }
SptImageMetadata class >> exampleWith: exifString [

	| instance |
	instance := self forImage: FileSystem memory root.
	instance metadata: (instance metadataFromExifOutput: exifString).
	^ instance
]

{ #category : 'examples' }
SptImageMetadata class >> exifOuputExample [

	^ 'ExifTool Version Number         : 13.30
File Name                       : IMG_6642.jpg
Directory                       : /Users/me/Pictures
File Size                       : 1502 kB
File Modification Date/Time     : 2024:05:18 17:07:20+02:00
File Access Date/Time           : 2024:05:21 03:55:21+02:00
File Inode Change Date/Time     : 2024:05:20 12:46:25+02:00
File Permissions                : -rwx------
File Type                       : JPEG
File Type Extension             : jpg
MIME Type                       : image/jpeg
JFIF Version                    : 1.01
Exif Byte Order                 : Big-endian (Motorola, MM)
Make                            : Apple
Camera Model Name               : iPhone 15 Pro Max'

]

{ #category : 'class initialization' }
SptImageMetadata class >> forImage: aFileReference [

	^ aFileReference 
		ifNil: [ SptNullImageMetadata new ] 
		ifNotNil: [ self new
						  image: aFileReference;
						  yourself ]
]

{ #category : 'private' }
SptImageMetadata >> basicUpdateMetadataNamed: aSymbol with: aString [

	| command |
	command := 'exiftool -{1}="{2}" {3}' format: {
						  aSymbol asString .
			           aString .
			           (file fullName surroundedBy: '"') }.

	LibC runCommand: command
]

{ #category : 'testing' }
SptImageMetadata >> exists [

	^ self file 
		ifNil: [ false ]
		ifNotNil: [ self file exists ]
]

{ #category : 'accessing' }
SptImageMetadata >> file [
	^ file
]

{ #category : 'accessing' }
SptImageMetadata >> fileName [
	file ifNil: [ ^ '' ].

	^ file exists
		ifTrue: [ file basename ]
		ifFalse: [ '' ]
]

{ #category : 'testing' }
SptImageMetadata >> hasImageDescription [
	
	^ self hasMetadataNamed: self imageDescriptionKey
]

{ #category : 'testing' }
SptImageMetadata >> hasMetadataNamed: aSymbol [
	
	^ self metadata includesKey: aSymbol
]

{ #category : 'initialization' }
SptImageMetadata >> image: aFileReference [
	
	file := aFileReference
]

{ #category : 'accessing - metadata' }
SptImageMetadata >> imageDescription [
	
	^ self metadataNamed: self imageDescriptionKey
]

{ #category : 'accessing - metadata' }
SptImageMetadata >> imageDescription: aString [

	self updateMetadataNamed: self imageDescriptionKey with: aString
]

{ #category : 'accessing - metadata' }
SptImageMetadata >> imageDescriptionKey [
	
	^ #'Image Description'
]

{ #category : 'accessing' }
SptImageMetadata >> imageFromFile [

	^ [ self file binaryReadStreamDo: [ :stream |
		  ImageReadWriter formFromStream: stream ] ]
		on: UnrecognizedImageFormatError 
		do: [ nil ]
]

{ #category : 'accessing - metadata' }
SptImageMetadata >> metadata [
	
	^ metadata ifNil: [ self updateMetadata ]
]

{ #category : 'private' }
SptImageMetadata >> metadata: aDictionary [
	
	metadata := aDictionary
]

{ #category : 'private' }
SptImageMetadata >> metadataFromExifOutput: aString [
	
	| entries |
	entries := Dictionary new.
	aString linesDo: [ : line | | parts |
		parts := $: split: line.
		entries at: parts first trimmed asSymbol put: parts second trimmed ].
	^ entries
]

{ #category : 'accessing - metadata' }
SptImageMetadata >> metadataNamed: aSymbol [
	
	^ self metadata at: aSymbol
]

{ #category : 'accessing - metadata' }
SptImageMetadata >> mimeType [
	
	^ self metadataNamed: #'MIME Type'
]

{ #category : 'private' }
SptImageMetadata >> readMetadata [
	
	^ self metadataFromExifOutput: (LibC resultOfCommand: 'exiftool ', (file fullName surroundedBy: '"'))
]

{ #category : 'resetting' }
SptImageMetadata >> resetImageDescription [

	self imageDescription: ''.
	self updateMetadata
]

{ #category : 'accessing - metadata' }
SptImageMetadata >> updateMetadata [
	
	^ metadata := self readMetadata
]

{ #category : 'accessing - metadata' }
SptImageMetadata >> updateMetadataNamed: aSymbol with: aString [
	
	self basicUpdateMetadataNamed: aSymbol with: aString.
	self updateMetadata
]
