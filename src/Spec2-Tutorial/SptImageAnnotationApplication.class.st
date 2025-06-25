"
Small application to visualize images and their metadata. 

```
SptImageAnnotationApplication new run.
```
"
Class {
	#name : 'SptImageAnnotationApplication',
	#superclass : 'SpApplication',
	#category : 'Spec2-Tutorial-Presenters',
	#package : 'Spec2-Tutorial',
	#tag : 'Presenters'
}

{ #category : 'instance creation' }
SptImageAnnotationApplication class >> startNewApplication [
	<script>

	^ self new run
]

{ #category : 'accessing' }
SptImageAnnotationApplication >> defaultConfigurationForMorphic [

	^ SptImageAnnotationConfiguration new
]

{ #category : 'running' }
SptImageAnnotationApplication >> start [ 

    (SptImageAnnotationPresenter newApplication: self) open
]
