"
Subclass me to automatically close a window in spec presenter tests.
"
Class {
	#name : 'SpecTestWithWindow',
	#superclass : 'TestCase',
	#instVars : [
		'window'
	],
	#category : 'Spec2-Tutorial-Tests-Model',
	#package : 'Spec2-Tutorial-Tests',
	#tag : 'Model'
}

{ #category : 'running' }
SpecTestWithWindow >> tearDown [ 

	window ifNotNil: [ window close ].
	super tearDown
]
