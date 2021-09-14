
<!DOCTYPE html>
<html lang="{{ $locale }}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="{{ asset('css/app.css') }}" rel="stylesheet">
    <link rel="shortcut icon" href="{{ asset('/storage/defaults/images/favicon.png') }}" type="image/x-icon">
    <title>{{ $title }}</title>
    <script>
      window.Settings = {!! $settings !!};
    </script>
</head>
<body>
  <div class="loading-background-wrapper" id="spa-loading-page">
    <div class="loader">
          <span></span>
          <span></span>
          <span></span>
          <span></span>
          <span></span>
          <span></span>
          <span></span>
          <span></span>
          <span></span>
          <span></span>
          <span></span>
          <span></span>
          <span></span>
          <span></span>
    </div>
</div>
<div id="app">
   <Master />
</div>  
<script src="{{ asset('js/app.js') }}"></script>
</body>
</html>
<style>
  :root{
    --color-primary: {!! $themes['primary']  !!};
    --color-secondary: {!! $themes['secondary']  !!};
    
    --dark-theme-bg-color: {!! $themes['dark']['background']  !!};
    --dark-theme-text-color:{!! $themes['dark']['text']  !!};
    --dark-theme-panel-bg-color:{!! $themes['dark']['panel']  !!};
    
    --light-theme-bg-color: {!! $themes['light']['background']  !!};
    --light-theme-text-color:{!! $themes['light']['text']  !!};
    --light-theme-panel-bg-color:{!! $themes['light']['panel']  !!};

    --card-box-shadow: 0px 3px 1px -2px rgba(73, 73, 73, 0.2), 0px 2px 2px 0px rgba(78, 78, 78, 0.14), 0px 1px 5px 0px rgba(77, 77, 77, 0.12);
    }
    #spa-loading-page .loader {
        z-index: -1;
    }
</style>