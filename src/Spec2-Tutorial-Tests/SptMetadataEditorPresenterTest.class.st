Class {
	#name : 'SptMetadataEditorPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'Spec2-Tutorial-Tests-Presenters',
	#package : 'Spec2-Tutorial-Tests',
	#tag : 'Presenters'
}

{ #category : 'tests' }
SptMetadataEditorPresenterTest >> testCanUpdateSelectedMetadata [

	| model newValue |
	model := SptTestImageMetadata example.
	presenter := SptMetadataEditorPresenter on: model.
	presenter keyList selectItem: #Make.
	newValue := 'my new data'.

	presenter valueInput text: newValue.
	presenter clickOnUpdate.

	self assert: (model metadataNamed: #Make) equals: newValue
	

	
]

{ #category : 'tests' }
SptMetadataEditorPresenterTest >> testSelectingAKeyUpdateValueFieldAccordingly [

	presenter := SptMetadataEditorPresenter on: SptImageMetadata example.
	
	presenter keyList selectFirst.
	
	self assert: presenter valueInput text equals: 'jpg'
	


]
