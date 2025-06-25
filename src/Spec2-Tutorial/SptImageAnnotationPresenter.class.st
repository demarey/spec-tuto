"
A presenter that allows you ot select a directory, navigate images and display the selected image and its metadata (using an `SptImageMetadataPresenter`)
"
Class {
	#name : 'SptImageAnnotationPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'directoryPresenter',
		'filesPresenter',
		'imagePresenter',
		'directoryLabelPresenter',
		'filesLabelPresenter'
	],
	#category : 'Spec2-Tutorial-Presenters',
	#package : 'Spec2-Tutorial',
	#tag : 'Presenters'
}

{ #category : 'examples' }
SptImageAnnotationPresenter class >> example [

	self new open
]

{ #category : 'initialization' }
SptImageAnnotationPresenter >> connectPresenters [

   "directoryPresenter whenSelectedItemChangedDo: [ self selectedDirectoryChanged ].
	filesPresenter whenSelectedItemChangedDo: [ self selectedFileChanged ]."
	
	directoryPresenter transmitTo: filesPresenter transform: [ :dirWrapper | 
			dirWrapper
				ifNil: [ #() ]
				ifNotNil: [ dirWrapper fileReference files ] ].
	filesPresenter 
		transmitTo: imagePresenter 
		transform: [ :file | SptImageMetadata forImage: file ]
]

{ #category : 'layout' }
SptImageAnnotationPresenter >> defaultLayout [ 

	^ SpPanedLayout newLeftToRight 
		positionOfSlider: 25 percent;
		add: (SpBoxLayout newTopToBottom
			spacing: 5;
			add: (SpBoxLayout newTopToBottom
				add: directoryLabelPresenter expand: false;
				add: directoryPresenter;
				yourself);
			add: (SpBoxLayout newTopToBottom
				add: filesLabelPresenter expand: false;
				add: filesPresenter;
				yourself);
			yourself);
		add: imagePresenter;
		yourself
]

{ #category : 'initialization' }
SptImageAnnotationPresenter >> initializePresenters [

	self addStyle: 'sptAnnotation'.

	directoryLabelPresenter := self newLabel 
		addStyle: 'sptHeader';
		label: 'Directories';
		yourself.
   directoryPresenter := self newTree
		addStyle: 'sptAnnotationDirectory';
		displayIcon: #icon;
		display: #label;
		roots: { StDirectoryWrapper on: FileLocator downloads };
		children: [ :aClass | aClass subdirectories ];
		expandRoots;
		beResizable;
		yourself.
		
	filesLabelPresenter := self newLabel 
		addStyle: 'sptHeader';
		label: 'Files';
		yourself.
	filesPresenter := self newList
		display: #basename;
		yourself.
		
	imagePresenter := self instantiate: SptImageMetadataPresenter on: nil
]

{ #category : 'initialization' }
SptImageAnnotationPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Image Annotation app'
]

{ #category : 'event handling' }
SptImageAnnotationPresenter >> selectedDirectoryChanged [

	| directory |
	directory := directoryPresenter selectedItem.
	directory ifNil: [ ^self ].
		
	filesPresenter items: directory fileReference files.
]

{ #category : 'event handling' }
SptImageAnnotationPresenter >> selectedFileChanged [

	| file |
	file := filesPresenter selectedItem.
	imagePresenter model: (SptImageMetadata forImage: file)
]
