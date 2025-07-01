"
Subclasses will automatically close all windows of the application of the presenter under test.
"
Class {
	#name : 'SpecTestWithManyWindows',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'Spec2-Tutorial-Tests-Model',
	#package : 'Spec2-Tutorial-Tests',
	#tag : 'Model'
}

{ #category : 'running' }
SpecTestWithManyWindows >> tearDown [

	presenter ifNotNil: [
		presenter application windows do: [ :window | window close ] ].

	super tearDown
]
