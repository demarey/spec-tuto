"
Null pattern for image metadata.
"
Class {
	#name : 'SptNullImageMetadata',
	#superclass : 'Object',
	#category : 'Spec2-Tutorial-Model',
	#package : 'Spec2-Tutorial',
	#tag : 'Model'
}

{ #category : 'accessing' }
SptNullImageMetadata >> file [
	^ (FileSystem memory root / 'null.image') ensureCreateFile
]

{ #category : 'accessing' }
SptNullImageMetadata >> metadata [

	^ Dictionary empty 
]
