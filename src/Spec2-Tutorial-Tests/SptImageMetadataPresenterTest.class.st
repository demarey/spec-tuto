Class {
	#name : 'SptImageMetadataPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'imagePresenter'
	],
	#category : 'Spec2-Tutorial-Tests-Presenters',
	#package : 'Spec2-Tutorial-Tests',
	#tag : 'Presenters'
}

{ #category : 'running' }
SptImageMetadataPresenterTest >> tearDown [ 
	imagePresenter ifNil: [ ^ self ].
	
	imagePresenter application windows 
		do: [ :window | window close ].
		
	super tearDown
	


]

{ #category : 'tests' }
SptImageMetadataPresenterTest >> testAddingImageDescriptionMetadataShouldDisplayImageDescriptionInImageMetadataPresenter [

	imagePresenter := SptImageMetadataPresenter on: SptTestImageMetadata example.
	self
		should: [ imagePresenter metadataNamed: 'ImageDescription' ]
		raise: NotFound.

	imagePresenter clickOnTag1.

	self
		assert: (imagePresenter metadataNamed: 'ImageDescription')
		equals: 'expo 1'
]

{ #category : 'tests' }
SptImageMetadataPresenterTest >> testClickingOnEditMetadataOpenTwoWindows [

	imagePresenter := SptImageMetadataPresenter 
							on: SptTestImageMetadata example.

	imagePresenter open.
	imagePresenter clickOnUpdateMetadata.

	self assert: imagePresenter application windows size equals: 2
	
	
	
	



]

{ #category : 'tests' }
SptImageMetadataPresenterTest >> testClickingOnResetOpenTwoWindows [

	imagePresenter := SptImageMetadataPresenter 
							on: SptTestImageMetadata example.

	imagePresenter open.
	SpWindowForceOpenNonModal 
		during: [ imagePresenter clickOnResetImageDescription ].

	self assert: imagePresenter application windows size equals: 2
	
	
	
	
	



]

{ #category : 'tests' }
SptImageMetadataPresenterTest >> testMouseOver [

	imagePresenter := SptImageMetadataPresenter on: SptTestImageMetadata example.

	imagePresenter eventHandler whenMouseMoveDo: [ :event | event position inspect]
]

{ #category : 'tests' }
SptImageMetadataPresenterTest >> testResetDescButtonIsDisabledWhenNoImageDescription [

	imagePresenter := SptImageMetadataPresenter on:
		                  SptTestImageMetadata example.

	self deny: imagePresenter resetDescButton isEnabled
]

{ #category : 'tests' }
SptImageMetadataPresenterTest >> testResetDescButtonIsEnabledAfterImageDescriptionSet [

	imagePresenter := SptImageMetadataPresenter on:
		                  SptTestImageMetadata example.
	self deny: imagePresenter resetDescButton isEnabled.

	imagePresenter clickOnTag1.

	self assert: imagePresenter resetDescButton isEnabled
]

{ #category : 'tests' }
SptImageMetadataPresenterTest >> testResetingImageDescriptionMetadataShouldRemoveItFromImageDescriptionInImageMetadataPresenterV1 [

	imagePresenter := SptImageMetadataPresenter on: (SptTestImageMetadata example
			                   imageDescription: 'testResetingImageDescription';
			                   yourself).
	imagePresenter model: imagePresenter model.
	self
		assert: (imagePresenter metadataNamed: 'ImageDescription')
		equals: 'testResetingImageDescription'.

	SpWindowForceOpenNonModal during: [
		imagePresenter clickOnResetImageDescription
		"pb => how to select the value from presenter open as non-modal ?"
	 ].

	self
		should: [ imagePresenter metadataNamed: 'ImageDescription' ]
		raise: NotFound
]

{ #category : 'tests' }
SptImageMetadataPresenterTest >> testResetingImageDescriptionMetadataShouldRemoveItFromImageDescriptionInImageMetadataPresenterV2 [

	imagePresenter := SptImageMetadataPresenter on: (SptTestImageMetadata example
			                   imageDescription: 'testResetingImageDescription';
			                   yourself).
	imagePresenter model: imagePresenter model.
	self
		assert: (imagePresenter metadataNamed: 'ImageDescription')
		equals: 'testResetingImageDescription'.

	SpWindowSimulateOpenModal 
		value: [ :aDialogPresenter | aDialogPresenter triggerOkAction ]
		during: [ imagePresenter clickOnResetImageDescription ].

	self
		should: [ imagePresenter metadataNamed: 'ImageDescription' ]
		raise: NotFound
]

{ #category : 'tests' }
SptImageMetadataPresenterTest >> testTag1LabelIsCorrect [

	imagePresenter := SptImageMetadataPresenter on: nil.
	
	self assert: imagePresenter tag1Button label equals: 'expo 1'
]
