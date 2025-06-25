"
A simple presenter to display image metadata in the form of key - value
"
Class {
	#name : 'SptMetadataPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'table'
	],
	#category : 'Spec2-Tutorial-Presenters',
	#package : 'Spec2-Tutorial',
	#tag : 'Presenters'
}

{ #category : 'examples' }
SptMetadataPresenter class >> example [

	<script>
	
	(self on: SptImageMetadata example) open
]

{ #category : 'layout' }
SptMetadataPresenter >> defaultLayout [ 

	^ SpBoxLayout newTopToBottom 
		add: 'Image metadata' expand: false;
		add: table;
		yourself
]

{ #category : 'initialization' }
SptMetadataPresenter >> initializePresenters [
    table := self newTable
        addColumn: (SpStringTableColumn title: 'Key' evaluated: [ :association | association key]);
        addColumn: (SpStringTableColumn title: 'Value' evaluated: [ :association | association value]);
		"addActionWith: [ :action | action name: 'zoom'; action: [ 1 halt ] ];"
        yourself.
]

{ #category : 'initialization' }
SptMetadataPresenter >> modelChanged [ 

	table items: (self model 
		ifNotNil: [ :aModel | aModel metadata associations ]
		ifNil: [ #() ]) 
]
