"
Small application to visualize images and their metadata. 

```
SptImageAnnotationApplication new start.
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

	^ self new 
		start;
		yourself
]

{ #category : 'running' }
SptImageAnnotationApplication >> start [ 
    SptImageAnnotationPresenter new open
]
