Class {
	#name : #BaselineOfWolfram,
	#superclass : #BaselineOf,
	#category : #BaselineOfWolfram
}

{ #category : #baselines }
BaselineOfWolfram >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'Wolfram';
			package: 'Wolfram-Tests' ]
]
