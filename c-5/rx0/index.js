import * as Observable from 'rxjs'
import { logValues } from '../rxcommon/logger.js'

let animals = Observable.of("ant", "bee", "cat", "dog", "elk")
let ticker = Observable.interval(500)

// 2つのストリームをマージするs
let combined = Observable.zip(animals, ticker)

// 結果のストリームは5秒ごとに値を発する
combined.subscribe(next => logValues(JSON.stringify(next)))
