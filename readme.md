
## Get started

<details>
  <summary>install homebrew</summary>

[homebrew][link#homebrew]

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

</details>



<details>
  <summary>install dart</summary>

[dart][link#dart]

```bash
brew install dart
```

</details>



<details>
  <summary>install android studio</summary>

[android studio][link#as]

```bash
brew install --cask android-studio
```

</details>



<details>
  <summary> update your path</summary>

- paste in your `~/.bashrc` or `~/.zshrc`

```bash
export PATH=$HOME/.pub-cache/bin:$PATH
export PATH=$HOME/fvm/default/bin:$PATH
ANDROID_HOME=$HOME/Library/Android/sdk
ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$ANDROID_HOME:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH
export PATH=$ANDROID_HOME/platform_tools:$PATH	
export PATH=$ANDROID_HOME/emulator:$PATH	
export JAVA_HOME=$(/usr/libexec/java_home)
```

- run `source ~/.<either bashrc or zshrc>`

</details>



<details>
  <summary>install flutter</summary>

[flutter][link#flutter]
[flutter version manager][link#fvm]

```bash
dart pub global activate fvm && \
fvm global stable && \
flutter doctor -v
```

</details>



<details>
  <summary>install protobuf</summary>

[dart][link#dart]

```bash
brew install protobuf && \
dart pub global activate protoc_plugin
```

</details>






[link#homebrew]: https://brew.sh/
[link#dart]: https://dart.dev/
[link#protobuf]: https://developers.google.com/protocol-buffers
[link#as]: https://developer.android.com/studio
[link#fvm]: https://fvm.app/
[link#flutter]: https://flutter.dev/
