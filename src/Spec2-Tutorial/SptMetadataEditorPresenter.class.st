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
		'keyInput',
		'valueInput',
		'updateButton'
	],
	#category : 'Spec2-Tutorial-Presenters',
	#package : 'Spec2-Tutorial',
	#tag : 'Presenters'
}

{ #category : 'layout' }
SptMetadataEditorPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpGridLayout new
				   build: [ :builder |
						   builder
							   add: 'Key:';
							   add: keyInput;
							   nextRow;
							   add: 'Value:';
							   add: valueInput ];
				   yourself);
		  add: updateButton expand: false
]

{ #category : 'initialization' }
SptMetadataEditorPresenter >> initializePresenters [ 

	keyInput := self newTextInput.
	valueInput := self newTextInput.
	updateButton := self newButton
		label: 'update metadata';
		action: [ self updateMetadata ];
		yourself
]

{ #category : 'initialization' }
SptMetadataEditorPresenter >> updateMetadata [

	self model
		updateMetadataNamed: keyInput text asSymbol
		with: valueInput text
]
