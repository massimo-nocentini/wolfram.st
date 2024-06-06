Extension { #name : 'Dictionary' }

{ #category : '*Wolfram' }
Dictionary >> putOnLink: aLink [

	(aLink head: 'Association' arguments: self associations) putOnLink:
		aLink
]
