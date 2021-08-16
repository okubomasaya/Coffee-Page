$(document).on 'turbolinks:load', ->
  $('[data-provider="summernote"]').each ->
    $(this).summernote
      height: 300
      placeholder:"記事を書きましょう！ハッシュタグ#を記事に入れてみましょう！（例）#マンデリン　#エチオピア　#ナチュラル"