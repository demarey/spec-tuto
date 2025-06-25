Class {
	#name : 'SptImageAnnotationConfiguration',
	#superclass : 'SpMorphicConfiguration',
	#category : 'Spec2-Tutorial',
	#package : 'Spec2-Tutorial'
}

{ #category : 'configuring' }
SptImageAnnotationConfiguration >> configure: anApplication [

	super configure: anApplication.
	self addStyleSheetFromString: self style
]

{ #category : 'accessing' }
SptImageAnnotationConfiguration >> style [

	^ '.application [
	.sptAnnotation [ 
		Container { #borderWidth: 2, #borderColor: EnvironmentColor(#background) },
		Draw { #backgroundColor: EnvironmentColor(#background) } ]	,
	.sptHeader [
		Draw { 
			#backgroundColor : EnvironmentColor(#window),
			#color : EnvironmentColor(#selectionText) },
		Font { 
			#name : EnvironmentFont(#default), 
			#size : 12 } ]	
	]'
]
