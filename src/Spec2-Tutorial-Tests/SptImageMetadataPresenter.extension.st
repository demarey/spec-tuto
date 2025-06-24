Extension { #name : 'SptImageMetadataPresenter' }

{ #category : '*Spec2-Tutorial-Tests' }
SptImageMetadataPresenter >> clickOnResetImageDescription [

	resetDescButton click
]

{ #category : '*Spec2-Tutorial-Tests' }
SptImageMetadataPresenter >> clickOnTag1 [

	tag1Button click
]

{ #category : '*Spec2-Tutorial-Tests' }
SptImageMetadataPresenter >> metadataNamed: aString [ 
	
	^ metadataPresenter metadataNamed: aString
]

{ #category : '*Spec2-Tutorial-Tests' }
SptImageMetadataPresenter >> resetDescButton [
	^ resetDescButton
]

{ #category : '*Spec2-Tutorial-Tests' }
SptImageMetadataPresenter >> tag1Button [
	^ tag1Button
]
