Class {
	#name : 'SpSimplePresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'Spec2-Tutorial-Tests-Presenters',
	#package : 'Spec2-Tutorial-Tests',
	#tag : 'Presenters'
}

{ #category : 'running' }
SpSimplePresenterTest >> tearDown [ 
	presenter ifNil: [ ^ self ].
	
	presenter application windows 
		do: [ :window | window close ].
		
	super tearDown
	


]
