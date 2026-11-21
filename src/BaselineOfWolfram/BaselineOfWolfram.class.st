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
			baseline: 'ContainersEssentials'
			with: [
			spec repository: 'github://massimo-nocentini/Containers-Essentials:master' ].

		spec
			baseline: 'LibPoppler'
			with: [
			spec repository: 'github://massimo-nocentini/libpoppler.st:master/src' ].

		spec
			baseline: 'Delimcc'
			with: [ spec repository: 'github://massimo-nocentini/delimcc.st:master' ].

		spec
			package: 'Wolfram'
			with: [ spec requires: #( 'ContainersEssentials' 'LibPoppler' ) ];
			package: 'Wolfram-Tests'
			with: [ spec requires: #( 'Wolfram' 'Delimcc' ) ] ]
]
