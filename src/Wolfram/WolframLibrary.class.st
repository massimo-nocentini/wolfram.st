Class {
	#name : #WolframLibrary,
	#superclass : #FFILibrary,
	#category : #Wolfram
}

{ #category : #'accessing platform' }
WolframLibrary >> unix64LibraryName [

	^ FFIUnix64LibraryFinder findLibrary: 'libWSTP64i4.so'
]
