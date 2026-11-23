"
I hold a handle of the WSTP library, in `handler`. My subclasses are `WolframEnvironment` and `WolframLink`, which override `releaseHandler` to release the resource in the library before I forget its handle.
"
Class {
	#name : 'WolframHandleHolder',
	#superclass : 'Object',
	#instVars : [
		'handler'
	],
	#category : 'Wolfram',
	#package : 'Wolfram'
}

{ #category : 'accessing' }
WolframHandleHolder >> handler [

	^ handler
]

{ #category : 'accessing' }
WolframHandleHolder >> handler: anObject [

	handler := anObject
]

{ #category : 'dispatched' }
WolframHandleHolder >> pushOnLua: L liblua: liblua [

	^ self handler pushOnLua: L liblua: liblua
]

{ #category : 'resources' }
WolframHandleHolder >> releaseHandler [

	handler := nil
]
