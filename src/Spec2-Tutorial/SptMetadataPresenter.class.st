"
A simple presenter to display image metadata in the form of key - value
"
Class {
	#name : 'SptMetadataPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'metadataPresenter',
		'metadataLabelPresenter'
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
		add: metadataLabelPresenter expand: false;
		add: metadataPresenter;
		yourself
]

{ #category : 'initialization' }
SptMetadataPresenter >> initializePresenters [


	metadataLabelPresenter := self newLabel
		addStyle: 'sptHeader';
		label: 'Image Metadata';
		yourself.
			
	metadataPresenter := self newTable
		addColumn: (SpStringTableColumn title: 'Key' evaluated: [ :association | association key]);
		addColumn: (SpStringTableColumn title: 'Value' evaluated: [ :association | association value]);
		yourself.
]

{ #category : 'initialization' }
SptMetadataPresenter >> modelChanged [ 

	table items: (self model 
		ifNotNil: [ :aModel | aModel metadata associations ]
		ifNil: [ #() ]) 
]
