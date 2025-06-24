Class {
	#name : 'SptImageAnnotationPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'window'
	],
	#category : 'Spec2-Tutorial-Tests-Presenters',
	#package : 'Spec2-Tutorial-Tests',
	#tag : 'Presenters'
}

{ #category : 'running' }
SptImageAnnotationPresenterTest >> tearDown [ 

	window ifNotNil: [ window close ].
	super tearDown
]

{ #category : 'tests' }
SptImageAnnotationPresenterTest >> testPresenterWindowTitleIsCorrect [

	| presenter |
	presenter := SptImageAnnotationPresenter new.
	
	window := presenter open.
	
	self assert: window title equals: 'Image Annotation app'
]
