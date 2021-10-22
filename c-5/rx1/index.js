import * as Observable from 'rxjs'
import { mergeMap } from 'rxjs/operators'
import { ajax } from 'rxjs/ajax'
import { logValues } from '../rxcommon/logger.js'

// リモートサイトからユーザーに関するデータを取得する
let users = Observable.of(3,2,1)

let result = users.pipe(
  mergeMap((user) => ajax.getJson('https://reqres.in/api/users/${user}'))
)

result.subscribe(
  resp => logValues(JSON.stringify(resp.data)),
  err => console.error(JSON.stringify(err))
)
