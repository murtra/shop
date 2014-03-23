Shop.onDocumentReady = (callback) ->
  $(document).ready(callback)
  $(document).on('page:load', callback)
