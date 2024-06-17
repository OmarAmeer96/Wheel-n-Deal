import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HCardsComponent } from './h-cards.component';

describe('HCardsComponent', () => {
  let component: HCardsComponent;
  let fixture: ComponentFixture<HCardsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HCardsComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(HCardsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
