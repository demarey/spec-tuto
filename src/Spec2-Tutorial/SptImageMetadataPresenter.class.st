"
A presenter that will display an image as well as its metadata (using an `SptMetadataPresenter`).
"
Class {
	#name : 'SptImageMetadataPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'imagePresenter',
		'metadataPresenter',
		'tag1Button',
		'resetDescButton',
		'editMetadataButton'
	],
	#category : 'Spec2-Tutorial-Presenters',
	#package : 'Spec2-Tutorial',
	#tag : 'Presenters'
}

{ #category : 'examples' }
SptImageMetadataPresenter class >> example [

	<script>
	
	| image |
	image := FileLocator downloads / 'nice-photo-set' / 'pexels-jay-brand-1763356224-32512240.jpg'.
	(self on: (SptImageMetadata forImage: image))
		open;
		model: (SptImageMetadata forImage: image)
]

{ #category : 'layout' }
SptImageMetadataPresenter >> defaultLayout [ 

	^ SpBoxLayout newLeftToRight
		spacing: 5; 
		add: (SpBoxLayout newTopToBottom 
			spacing: 10;
			add: imagePresenter;
			add: tag1Button expand: false;
			add: resetDescButton expand: false;
			yourself);
		add: metadataPresenter;
		yourself
]

{ #category : 'private' }
SptImageMetadataPresenter >> emptyImage [

	^ Form extent: 0 @ 0 depth: 0 bits: #( )
]

{ #category : 'actions' }
SptImageMetadataPresenter >> imageDescription: aString [

	self model imageDescription: aString.
	metadataPresenter model: self model.
]

{ #category : 'private' }
SptImageMetadataPresenter >> imageFromFile [

	^ [ self model file binaryReadStreamDo: [ :stream |
		  ImageReadWriter formFromStream: stream ] ]
		on: UnrecognizedImageFormatError 
		do: [ self emptyImage ]
]

{ #category : 'initialization' }
SptImageMetadataPresenter >> initializePresenters [

	metadataPresenter := self
		                     instantiate: SptMetadataPresenter
		                     on: self model.
	imagePresenter := self newImage
		                  image: self emptyImage;
		                  autoScale: true;
		                  yourself.
	tag1Button := self newButton
		              label: 'expo 1';
		              action: [ self imageDescription: 'expo 1' ];
		              yourself.
	resetDescButton := self newButton
		              label: 'reset image description';
		              action: [ self resetImageDescription ];
		              yourself.
]

{ #category : 'initialization' }
SptImageMetadataPresenter >> modelChanged [

	self model ifNil: [
			self model: SptNullImageMetadata new.
			^ self ].

	imagePresenter image: self imageFromFile.
	metadataPresenter model: self model
]

{ #category : 'actions' }
SptImageMetadataPresenter >> openMetadataEditor [
	
	(SptMetadataEditorPresenter on: self model) open
]

{ #category : 'actions' }
SptImageMetadataPresenter >> resetImageDescription [

	| confirmed |
	confirmed := self confirm: 'Delete imageDescription'.
	confirmed ifFalse: [ ^ self ].

	self model resetImageDescription.
	metadataPresenter model: self model.
]
