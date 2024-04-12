const express = require('express');
const app = express();
const db = require('./db.js');
const bodyParser = require('body-parser');
const PORT = process.env.PORT || 4000;
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true}));
// 이 코드가 없으면 post를 할수가 없다!
app.use(express.json());

// 모든 note 조회
app.get('/getAllNoteList', (req, res) => {
    db.query('select * from note', (err, data) => {
        return res.json(data);
    })
});

// 특정 note 조회
app.get('/getNote/:id', (req, res) => {
    const { id } = req.params;
    db.query(`select * from note where id="${id}"`, (err, data) => {
        return res.json(data);
    });
})

// 특정 제목(title)을 가진 게시물만 가져오기
app.get('/getLikeNote/:title', (req, res) => {
    const { title } = req.params;
    db.query(`select * from note where title like "%${title}%"`, (err, data) => {
        return res.json(data);
    })
})

// note 작성하기
app.post('/addNote', (req, res) => {
    const { title, text } = req.body;

    db.query(`insert into note(title, text, date) values("${title}", "${text}", now())`, (err, data) => {
        return res.json(data);
    })
})

// note 수정하기
app.put('/updateNote', (req, res) => {
    const {id, title, text} = req.body;

    db.query(`update note set title="${title}", text="${text}" where id="${id}"`, (err, data) => {
        return res.json(data);
    })
})

// 특정 note 삭제하기
app.delete('/deleteNote/:id', (req, res) => {
    const { id } = req.params;

    db.query(`delete from note where id="${id}"`, (err, data) => {
        return res.json(data);
    })
})

app.listen(PORT, () => {
    console.log(`Server On http://localhost:${PORT}`);
});