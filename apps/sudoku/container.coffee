GridActions = require('./actions/GridActions')

mapDispatchToProps = (dispatch) ->
  setNumber: (index, number) ->
    dispatch GridActions.setNumber(index, number)

connector = ReactRedux.connect(((state) -> state), mapDispatchToProps)

module.exports = React.createFactory(
  connector(require('./app'))
)
