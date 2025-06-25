Extension { #name : 'SptMetadataPresenter' }

{ #category : '*Spec2-Tutorial-Tests' }
SptMetadataPresenter >> metadataNamed: aString [

	^ (table items detect: [ :association |
		   association key = aString asSymbol ]) value
]
