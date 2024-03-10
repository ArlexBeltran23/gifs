import { Component, OnInit } from '@angular/core';
import { GifsService } from 'src/app/gifs/services/gifs.service';

@Component({
    selector: 'app-sidebar',
    templateUrl: 'sidebar.component.html'
})

export class SidebarComponent  {
    
    constructor(private gifsService: GifsService) { }

    get tags(){
        return this.gifsService.tagsHistory;
    }

    searchTag(tag: string){
        this.gifsService.searchTag(tag)
    }
 
}