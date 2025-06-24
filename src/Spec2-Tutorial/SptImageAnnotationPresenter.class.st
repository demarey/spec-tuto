"
A presenter that allows you ot select a directory, navigate images and display the selected image and its metadata (using an `SptImageMetadataPresenter`)
"
Class {
	#name : 'SptImageAnnotationPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'directoryPresenter',
		'filesPresenter',
		'imagePresenter'
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
		add: (SpBoxLayout newTopToBottom 
			add: directoryPresenter;
			add: filesPresenter;
			yourself);
		add: imagePresenter;
		positionOfSlider: 20 percent;
		yourself
]

{ #category : 'initialization' }
SptImageAnnotationPresenter >> initializePresenters [
   directoryPresenter := self newTreeTable 
		addColumn:
			(SpCompositeTableColumn new
				title: 'Directories';
				addColumn:
					(SpImageTableColumn new
						width: 20;
						evaluated: #icon;
						yourself);
				addColumn:
					(SpStringTableColumn new
						evaluated: #label;
						yourself);
				yourself);
		roots: { StDirectoryWrapper on: FileLocator downloads };
		children: [ :aClass | aClass subdirectories ];
		expandRoots;
		beResizable;
		yourself.
	filesPresenter := self newList
		display: [ :each | each basename ];
		yourself.
	imagePresenter := self instantiate: (SptImageMetadataPresenter on: nil).
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
