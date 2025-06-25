Extension { #name : 'SptMetadataPresenter' }

{ #category : '*Spec2-Tutorial-Tests' }
SptMetadataPresenter >> metadataNamed: aString [

	^ (metadataPresenter items detect: [ :association |
		   association key = aString asSymbol ]) value
]
