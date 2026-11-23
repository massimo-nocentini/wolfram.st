"
I am the Metacello baseline of the project. I load the packages `Wolfram` and `Wolfram-Tests`, after the projects that they need: `ContainersEssentials` and `LibPoppler` for the first, `Delimcc` for the tests.
"
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
