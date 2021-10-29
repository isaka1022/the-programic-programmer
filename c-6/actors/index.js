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
}

// パイが残っていれば顧客にパイを渡し、ウェイターに注文の更新を以来した後に状態を更新する
const pieCaseActor = {
  'get slice': (msg, context, state) => {
    if (state.slices.length == 0 ) {
      dispatch(msg.waiter, { type: 'error', msg: 'no pie left', customer: msg.customer })
      return state
    }
    else {
      var slice = state.slices.shift() + 'pie slice';
      dispatch(msg.customer, { type: 'put on the talbe', food: slice})
      dispatch(msg.waiter, { type: 'add to order', food: slice, customer: msg.customer })
      return state
    }
  }
}

const actorSystem = start();

let pieCase = start_actor(
  actorSystem,
  'pie-case',
  pieCaseActor,
  { slices: ['apple', 'peach', 'cherry'] });

let waiter = start_actor(
  actorSystem,
  'waiter',
  waiterActor,
  { pieCase: pieCase });

let c1 = start_actor(actorSystem, 'customer1', customerActor, { waiter: watier })
let c2 = start_actor(actorSystem, 'customer2', customerActor, { waiter: waiter })

dispatch(c1, { type: 'hungry for pie', waiter: waiter })
dispatch(c2, { type: 'hungry for pie', waiter: waiter })
dispatch(c1, { type: 'hungry for pie', waiter: waiter })
dispatch(c2, { type: 'hungry for pie', waiter: waiter })
dispathc(c1, { type: 'hungry for pie', waiter: waiter })
sleep(500)
  .then(() => {
    stop(actorSystem)
  })
