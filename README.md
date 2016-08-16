# MoyaUnbox
[Unbox](https://github.com/JohnSundell/Unbox) mappings for [Moya](https://github.com/Moya/Moya) network requests, includes [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) and [RxSwift](https://github.com/ReactiveX/RxSwift) support.

## Installation

### Carthage

Add `github JaviLorbada/MoyaUnbox` to your `Cartfile`.

Carthage will build three frameworks, `MoyaUnbox`, `RxMoyaUnbox` and `ReactiveMoyaUnbox`, once then just import the one you need depends on your preference.

## Usage

### Unbox Model

First you need to create your model, for example a GitHub user based on their user [API](https://api.github.com/users/octocat).

```swift
struct GHUser {
  let login: String
  let identifier: Int
  let avatarURL: NSURL
  …
}

extension GHUser: Unboxable {
  init(unboxer: Unboxer) {
    self.login = unboxer.unbox("login")
    self.identifier = unboxer.unbox("id")
    self.avatarURL = unboxer.unbox("avatar_url")
    …
  }
}
```

Then you need do the mappings.

### 1. Moya

After you create your own API provider like 

`let provider = MoyaProvider<GitHubAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])`

you could use `mapObject` and `mapArray` for the response:

```swift
provider.request(.UserProfile("octocat"),   
completion: { result in
	do {
	  if let user = try result.value?.mapObject(GHUser) {
	    print("User: \(user)")
	  } else {
	    print(result.error)
		}
	} catch {
	  print(error)
	}
})
```

### 2. RxSwift

If you use Moya RxSwift extensions, you can use `RxMoyaUnbox` extension.

```swift
 provider.request(.UserProfile("JaviLorbada"))
    .filterSuccessfulStatusCodes()
    .mapObject(GHUser)
    .observeOn(MainScheduler.instance)
    .subscribe(onNext: { user in
      print("User: \(user)")
    }, onError: { error in
	    print(error)
    })
    .addDisposableTo(disposeBag)
```

### 3. ReactiveCocoa

If you use Moya ReactiveCocoa extensions, you can use `ReactiveMoyaUnbox` extension.

```swift
 provider.request(.UserProfile("JaviLorbada"))
    .filterSuccessfulStatusCodes()
    .mapObject(GHUser)
    .observeOn(UIScheduler())
    .startWithResult { result in
    if let user = result.value {
      print("User: \(user)")
    } else { 
	    print(result.error)
    }
  }
```

### Tests
The project contains some tests as an example. If you wanna check it out,

1. Clone the repo `git clone https://github.com/JaviLorbada/MoyaUnbox`
2. Run the setup script on `$ bin/setup-iOS `

## Contributing 
Issues / Pull Requests / Feedback welcome 

## Thanks
This project took inspiration on all the other [Moya Mappings](https://github.com/Moya/Moya#community-extensions). If you use any other JSON serialisation library you should check them out.

## License

MoyaUnbox is available under the MIT license. See the [LICENSE](https://github.com/JaviLorbada/MoyaUnbox/blob/master/LICENSE) file for more info.

## Contact: 

- [Javi Lorbada](mailto:javugi@gmail.com) 
- Follow [@javi_lorbada](https://twitter.com/javi_lorbada) on twitter
- [http://javilorbada.me/](http://javilorbada.me/)