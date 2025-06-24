"
I'm a simplified version of my superclass that will ease and faster testing.
Instead of relying on a image of the file system and using exiftool to get the metadata, I keep metadata in a dictionary and save it in another dictionary simulating storing of the metadata in the image file.
A read of the metadata will simply set the dictionary used to persist data as the current metadata.
"
Class {
	#name : 'SptTestImageMetadata',
	#superclass : 'SptImageMetadata',
	#instVars : [
		'persistedMetadata'
	],
	#category : 'Spec2-Tutorial-Tests-Model',
	#package : 'Spec2-Tutorial-Tests',
	#tag : 'Model'
}

{ #category : 'class initialization' }
SptTestImageMetadata class >> forImage: aFileReference [

	"we do not care about the real file"
	^ self new
]

{ #category : 'private' }
SptTestImageMetadata >> basicUpdateMetadataNamed: aSymbol with: aString [

	persistedMetadata := metadata copyWith: aSymbol -> aString.
	persistedMetadata keysAndValuesRemove: [ :key :value | value isEmptyOrNil ]
]

{ #category : 'accessing' }
SptTestImageMetadata >> file [ 

	UnrecognizedImageFormatError signal
]

{ #category : 'accessing' }
SptTestImageMetadata >> metadata: aDictionary [

	metadata := persistedMetadata := aDictionary
	
]

{ #category : 'private' }
SptTestImageMetadata >> readMetadata [ 
	
	metadata := persistedMetadata.
	^ metadata
]
