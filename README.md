# Ruby on WebAssembly

Welcome! 👋

This is the repo for the `wasm` gem and also a place to start a conversation about Ruby and WebAssembly, and how our community might leverage this new capability. For some background, [check out my blog post](http://www.blacktm.com/blog/ruby-on-webassembly) on the subject. This is largely an experiment at the moment — there are plenty of things this gem doesn't do, but it's a starting point and will hopefully get you up and running quickly so we can learn and explore together.

Feel free to open an issue about anything at all, even just to chat. Enjoy!

## Building the gem and dependencies

Run `rake` to build this gem and install locally.

Use `rake mruby_latest` to set the MRuby submodule to the latest release and `rake mruby_master` to switch to the master branch.

Run `rake build_mruby` to build an MRuby static library for WebAssembly, which will be placed in the `assets/` directory (a prebuilt one is already there).

When a new version of MRuby is released, update the version number in the `Rakefile`, run `rake mruby_latest`, and `rake build_mruby`.

## Using the gem

Get it with `gem install wasm`

Once installed, you'll have access to the `ruby-wasm` command-line utility. Use this utility to build and serve Ruby apps for WebAssembly. Running it without any options will print its usage. Troubleshoot your WebAssembly toolchain with `ruby-wasm doctor`

What this gem currently does:
- Compile a single Ruby script to a binary `.wasm` file

What it doesn't do yet (maybe something you'd like to work on 🤔):
- Build several scripts at a time, or pull in others via `require`
- Allow you to call JavaScript from Ruby, or vice versa
- Use any arbitrary Ruby gem; we're using MRuby here, so you _can_ use [mrbgems](https://github.com/mruby/mruby/wiki/Mrbgems-FAQ) ([see list](https://github.com/mruby/mgem-list))
- Fetch and interpret a Ruby script on page load

### A quick example

First, make sure you have the WebAssembly toolchain installed and activated — see the ["Getting Started" guide](http://webassembly.org/getting-started/developers-guide) for details.

Start by installing this gem:

```
gem install wasm
```

Make sure you have this `wasm` gem installed. Remember, you can check for issues using `ruby-wasm doctor`

Then create a test dir for some example Ruby code:

```
mkdir ruby-wasm-test
cd ruby-wasm-test
echo 'puts "#{MRUBY_DESCRIPTION}"' > hello.rb
```

If you've installed using `gem`, you won't have a working mruby library, so run:

```
ruby-wasm vendor_mruby
ruby-wasm build_mruby
```

This will create a dir called 'mruby' with the emscripten-compatible build_config.rb copied over. You can edit this to ie. include more mrb-gems in your build.

Now we'll finally compile that Ruby file for the browser:

```
ruby-wasm build hello.rb
```

This will create a `build/` directory and generate the following files:
- `app.wasm` — Our compiled Ruby app in binary WebAssembly format
- `app.js` — JavaScript needed to fetch our `.wasm` binary and initialize the WebAssembly environment ([learn more](http://webassembly.org/getting-started/js-api))
- `app.html` — A simple HTML template with a `<script>` tag to load the JavaScript file above

To view our Ruby WebAssembly app in the browser, we'll have to serve the files over HTTP (the JavaScript above will use the [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) to load the `.wasm` binary). Run `ruby-wasm serve` to do this.

Finally, open your favorite web browser and go to `http://localhost:8000/app.html`. Open your web inspector / developer tools and you'll see "Hello Ruby!" printed in the console. Exciting! 🙌
