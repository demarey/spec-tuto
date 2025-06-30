"
I'm a simple presenter used to update any kind of metadata.

```
(SptMetadataEditorPresenter on: SptImageMetadata example) open
```
"
Class {
	#name : 'SptMetadataEditorPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'valueInput',
		'updateButton',
		'keyList'
	],
	#category : 'Spec2-Tutorial-Presenters',
	#package : 'Spec2-Tutorial',
	#tag : 'Presenters'
}

{ #category : 'examples' }
SptMetadataEditorPresenter class >> example [

	(self on: SptImageMetadata example) open
]

{ #category : 'accessing' }
SptMetadataEditorPresenter >> availableKeys [

	^ self model metadata keys
]

{ #category : 'initialization' }
SptMetadataEditorPresenter >> connectPresenters [

	keyList items: self availableKeys.
	keyList transmitTo: valueInput transform: [ :key | self model metadataNamed: key ]
]

{ #category : 'layout' }
SptMetadataEditorPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		  add: keyList;
		  add: (SpBoxLayout newTopToBottom
				   add: 'Value:' expand: false;
				   add: valueInput expand: false;
				   add: updateButton expand: false;
					vAlignCenter;
					spacing: 10;
				   yourself);
		  yourself
]

{ #category : 'initialization' }
SptMetadataEditorPresenter >> initializePresenters [ 

	keyList := self newList.
	valueInput := self newTextInput.
	updateButton := self newButton
		label: 'update metadata';
		action: [ self updateMetadata ];
		yourself
]

{ #category : 'initialization' }
SptMetadataEditorPresenter >> updateMetadata [

	self model
		updateMetadataNamed: keyList selectedItem
		with: valueInput text
]
