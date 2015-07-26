# Dashing WerckerList widget

A [Dashing](http://github.com/shopify/dashing) widget for [Wercker](http://wercker.com)

![](/screenshots/screenshot_list.png?raw=true)

## Requirements

1. [Dashing](http://github.com/shopify/dashing)
2. A [Wercker](http://wercker.com) account
3. The contents of this repo

## Setup

1. `git clone git@github.com:ertrzyiks/dashing-wercker-list.git`
2. Copy Wercker logo to your assets

  ```
  mkdir -p dashing/assets/images
  cp dashing-wercker-list/assets/images/wercker_logo_shield_black.png dashing/assets/images
  ```
3. Copy `WerckerList` widget into your dashing project widgets

  ```
  mkdir -p dashing/widgets/wercker_list
  cp -R dashing-wercker-list/widgets/wercker_list dashing/widgets/wercker_list
  ```
4. Add `wercker_list.rb` job to dashing jobs

  ```
  cp dashing-wercker-list/jobs/wercker_list.rb dashing/jobs
  ```

## Config

There is config array on the top of jobs/wercker_list.rb:

```
projects = [
  { :name => 'Example1', :user => 'YOUR_USER', :application => 'YOUR_APPLICATION1', :branch => 'master' },
  { :name => 'Example2', :user => 'YOUR_USER', :application => 'YOUR_APPLICATION2', :branch => 'master' }
]
```

Fill it with Wercker application informations and choose branch.

[Generate token](https://app.wercker.com/#profile/tokens) and expose it in `WERCKER_AUTH_TOKEN` environment variable.

## Dashboard

To display your dashboard you can use the `dashboards/wercker.erb` as example:

```html
<div class="gridster">
  <ul>
    <li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
      <div data-id="wercker-list" data-view="WerckerList" data-title="Wercker status"></div>
    </li>
  </ul>
</div>
```
