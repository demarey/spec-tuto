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
		'editMetadataButton',
		'imageLabelPresenter',
		'noImageLabelPresenter'
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

	^ SpPanedLayout newTopToBottom 
		positionOfSlider: 65 percent;
		add: (SpBoxLayout newTopToBottom 
			spacing: 10;
			add: (SpOverlayLayout new
				addOverlay: noImageLabelPresenter;
				child: (SpBoxLayout newTopToBottom 
					add: (SpBoxLayout newLeftToRight 
						hAlignCenter;
						borderWidth: 5;
						add: imageLabelPresenter;
						yourself) expand: false;
					add: imagePresenter;
					yourself);
				yourself);
			add: (SpBoxLayout  newLeftToRight 
					spacing: 5;
					add: tag1Button;
					add: resetDescButton;
					yourself)
				expand: false;
			yourself);
		add: metadataPresenter;
		yourself
]

{ #category : 'private' }
SptImageMetadataPresenter >> emptyImage [

	^ Form extent: 0 @ 0 depth: 0 bits: #( )
]

{ #category : 'testing' }
SptImageMetadataPresenter >> hasImageDescriptionMetadata [

	^ self model
		  ifNil: [ false ]
		  ifNotNil: [ self model hasImageDescription ]
]

{ #category : 'actions' }
SptImageMetadataPresenter >> imageDescription: aString [

	self model imageDescription: aString.
	self modelChanged.
	resetDescButton enable.
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

	metadataPresenter := self instantiate: SptMetadataPresenter on: self model.

	noImageLabelPresenter := self newLabel 
		label: 'No image selected';
		yourself.
	
	imageLabelPresenter := self newLabel 
		addStyle: 'title';
		yourself.

	imagePresenter := self newImage
		autoScale: true;
		yourself.

	tag1Button := self newButton
		label: 'expo 1';
		action: [ self imageDescription: 'expo 1' ];
		yourself.
	
	editMetadataButton := self newButton
		label: 'Edit metadata';
		action: [ self openMetadataEditor ];
		yourself.
	
	resetDescButton := self newButton
		label: 'Reset Metadata';
		action: [ self resetImageDescription ];
		enabled: self hasImageDescriptionMetadata;
		yourself
]

{ #category : 'initialization' }
SptImageMetadataPresenter >> modelChanged [

	self model ifNil: [
		self model: SptNullImageMetadata new.
		^ self ].

	self model  exists  
		ifTrue: [ 
			noImageLabelPresenter hide.
			imageLabelPresenter label: self model file basename.
			imagePresenter image: self imageFromFile ]
		ifFalse: [ 
			noImageLabelPresenter show.
			imageLabelPresenter label: ''.
			imagePresenter image: nil ].
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
