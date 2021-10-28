// 顧客は次の3つのメッセージを受け取る
// ・お腹を空かせる
// ・テーブルに牌がある
// ・パイがないというお詫び

const customerActor = {
  'hungry or pie' : (msg, ctx, state) => {
    return dispatch(state.waiter, { type: 'order', customer: ctx.self, wants: 'pie' })
  },

  'put on table' : (msg, ctx, _state) => console.log(`${stx.self.name} seees "${msg.food}" appears on the table`),

  'no pie left' : (_msg, ctx, _state) => console.log(`${ctx.self.name} sulks ...`)
}


// Orderを受け取った際にパイの要求かどうかを確認する
const waiterActor = {
  "order": (msg, ctx, state) => {
    if (msg.wants == 'pie') {
      dispatch(state.pieCase, { type: 'get slice', customer: msg.customer, waiter: ctx.self })
    }
    else {
      console.dir(`Dont't know to order ${msg.wants}`)
    }
  },

  "add to order" : (msg, ctx) => console.log(`Waiter adds ${msg.food} to ${msg.customer.name}'s order'`),

  "error": (msg, ctx) => {
    dispatch(msg.customer, { type: 'no pie left', msg: msg.msg });
    console.log(`/nThe waiter apologize to ${msg.customer.name}: ${msg.msg}`)
  }
  
