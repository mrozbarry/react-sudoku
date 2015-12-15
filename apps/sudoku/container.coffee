mapDispatchToProps = (dispatch) ->
  someMethod: (stuff) ->
    dispatch({ type: 'NO-OP', stuff: stuff })

connector = ReactRedux.connect(((state) -> state), mapDispatchToProps)

module.exports = React.createFactory(
  connector(require('./app'))
)
