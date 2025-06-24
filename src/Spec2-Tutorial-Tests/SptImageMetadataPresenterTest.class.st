Class {
	#name : 'SptImageMetadataPresenterTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Tutorial-Tests-Presenters',
	#package : 'Spec2-Tutorial-Tests',
	#tag : 'Presenters'
}

{ #category : 'tests' }
SptImageMetadataPresenterTest >> testAddingImageDescriptionMetadataShouldDisplayImageDescriptionInImageMetadataPresenter [

	| imagePresenter |
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
SptImageMetadataPresenterTest >> testMouseOver [
	| imagePresenter |
	imagePresenter := SptImageMetadataPresenter on: SptTestImageMetadata example.

	imagePresenter eventHandler whenMouseMoveDo: [ :event | event position inspect]
]

{ #category : 'tests' }
SptImageMetadataPresenterTest >> testResetDescButtonIsDisabledWhenNoImageDescription [

	| imagePresenter |
	imagePresenter := SptImageMetadataPresenter on: SptTestImageMetadata example.
	
	self deny: imagePresenter resetDescButton isEnabled
	
	"to do: implement disable on change in metadata in imagePresenter"

]

{ #category : 'tests' }
SptImageMetadataPresenterTest >> testResetingImageDescriptionMetadataShouldRemoveItFromImageDescriptionInImageMetadataPresenterV1 [

	| imagePresenter |
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

	| imagePresenter |
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

	| imagePresenter |
	imagePresenter := SptImageMetadataPresenter on: SptTestImageMetadata example.
	
	self assert: imagePresenter tag1Button label equals: 'expo 1'
]
